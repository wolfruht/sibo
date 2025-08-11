#!/bin/bash

CONFIG_FILE="./sibo.conf"
DEFAULT_MENU_LANG="en"
DEFAULT_OCR_LANG="eng"

# Standardkonfiguration erstellen
create_default_config() {
    cat <<EOL > "$CONFIG_FILE"
MENU_LANG=$DEFAULT_MENU_LANG
OCR_LANG=$DEFAULT_OCR_LANG
EOL
}

# Konfiguration laden
load_config() {
    [[ ! -f "$CONFIG_FILE" ]] && create_default_config
    source "$CONFIG_FILE"
}

# Konfiguration speichern
save_config() {
    echo "MENU_LANG=$MENU_LANG" > "$CONFIG_FILE"
    echo "OCR_LANG=$OCR_LANG" >> "$CONFIG_FILE"
}

# Sprache wählen (Initiale Auswahl)
choose_language() {
    LANG_SELECTION=$(zenity --list --title="Sprache auswählen / Choose language" \
        --text="Wählen Sie Ihre Sprache / Choose your language:" \
        --column="Sprache / Language" "de" "en")

    if [[ "$LANG_SELECTION" == "de" ]]; then
        MENU_LANG="de"
        OCR_LANG="deu"
    else
        MENU_LANG="en"
        OCR_LANG="eng"
    fi

    save_config
}

# Spracheinstellungen ändern
change_language_settings() {
    if [[ "$MENU_LANG" == "de" ]]; then
        MENU_LANG_SELECTION=$(zenity --list --title="Spracheinstellungen" \
            --text="Wählen Sie die Menüsprache:" \
            --column="Sprache" "en" "de")
        OCR_LANG_SELECTION=$(zenity --list --title="OCR-Sprache" \
            --text="Wählen Sie die OCR-Sprache:" \
            --column="OCR-Sprache" "eng" "deu")
    else
        MENU_LANG_SELECTION=$(zenity --list --title="Language Settings" \
            --text="Choose menu language:" \
            --column="Language" "en" "de")
        OCR_LANG_SELECTION=$(zenity --list --title="OCR Language" \
            --text="Choose OCR language:" \
            --column="OCR Language" "eng" "deu")
    fi

    [[ -n "$MENU_LANG_SELECTION" ]] && MENU_LANG="$MENU_LANG_SELECTION"
    [[ -n "$OCR_LANG_SELECTION" ]] && OCR_LANG="$OCR_LANG_SELECTION"
    save_config
}

# OCR aus Datei (Bild oder PDF)
run_ocr_from_file() {
    if [[ "$MENU_LANG" == "de" ]]; then
        FILE=$(zenity --file-selection --title="Bild oder PDF auswählen")
    else
        FILE=$(zenity --file-selection --title="Select image or PDF")
    fi
    [[ -z "$FILE" ]] && return

    if [[ "$FILE" == *.pdf ]]; then
        TEMP_DIR=$(mktemp -d)
        pdftoppm "$FILE" "$TEMP_DIR/page" -png

        PAGE_NUM=1
        OCR_TEXT=""
        for IMG in "$TEMP_DIR"/page*.png; do
            TMP_OUT=$(mktemp)
            tesseract "$IMG" "$TMP_OUT" -l "$OCR_LANG" 2>/dev/null
            OCR_TEXT+="\n\nPage $PAGE_NUM:\n$(cat "${TMP_OUT}.txt")"
            PAGE_NUM=$((PAGE_NUM + 1))
            rm -f "$TMP_OUT" "${TMP_OUT}.txt"
        done
        rm -rf "$TEMP_DIR"
    else
        TMP_OUT=$(mktemp)
        tesseract "$FILE" "$TMP_OUT" -l "$OCR_LANG" 2>/dev/null
        OCR_TEXT=$(cat "${TMP_OUT}.txt")
        rm -f "$TMP_OUT" "${TMP_OUT}.txt"
    fi

    TXT="${FILE%.*}_ocr.txt"
    HTML="${FILE%.*}_ocr.html"
    echo "$OCR_TEXT" > "$TXT"
    echo "<html><body><pre>$OCR_TEXT</pre></body></html>" > "$HTML"

    if [[ "$MENU_LANG" == "de" ]]; then
        zenity --info --text="Ergebnis gespeichert als:\n$TXT\n$HTML"
    else
        zenity --info --text="Result saved as:\n$TXT\n$HTML"
    fi
}

# Bild vom Scanner scannen und OCR anwenden
scan_image() {
    if ! command -v scanimage &> /dev/null; then
        zenity --error --text="scanimage not found. Please install SANE."
        return
    fi

    if [[ "$MENU_LANG" == "de" ]]; then
        SAVE_DIR=$(zenity --file-selection --directory --title="Speicherort wählen")
    else
        SAVE_DIR=$(zenity --file-selection --directory --title="Choose save location")
    fi

    [[ -z "$SAVE_DIR" ]] && return

    OUT_IMG="$SAVE_DIR/scan_output.png"
    scanimage --format=png --resolution 300 --output-file="$OUT_IMG"

    if [[ ! -f "$OUT_IMG" ]]; then
        zenity --error --text="Scan fehlgeschlagen / Scan failed."
        return
    fi

    TMP_OUT=$(mktemp)
    tesseract "$OUT_IMG" "$TMP_OUT" -l "$OCR_LANG" 2>/dev/null
    OCR_TEXT=$(cat "${TMP_OUT}.txt")
    rm -f "$TMP_OUT" "${TMP_OUT}.txt"

    TXT="${OUT_IMG%.*}_ocr.txt"
    HTML="${OUT_IMG%.*}_ocr.html"
    echo "$OCR_TEXT" > "$TXT"
    echo "<html><body><pre>$OCR_TEXT</pre></body></html>" > "$HTML"

    if [[ "$MENU_LANG" == "de" ]]; then
        zenity --info --text="Ergebnis gespeichert als:\n$TXT\n$HTML"
    else
        zenity --info --text="Result saved as:\n$TXT\n$HTML"
    fi
}

# Versionsinfo anzeigen
show_version_info() {
    TEXT="SIBO 0.1\nSupports OCR for images and PDFs.\nSupport: wolfruht@mail.de"
    [[ "$MENU_LANG" == "de" ]] && TEXT="SIBO 0.1\nUnterstützt OCR für Bilder und PDFs.\nSupport: wolfruht@mail.de"
    zenity --info --title="Version" --text="$TEXT"
}

# Support-Info anzeigen
show_support_info() {
    TEXT="For support, contact: wolfruht@mail.de\nMore: www.example.com"
    [[ "$MENU_LANG" == "de" ]] && TEXT="Für Support: wolfruht@mail.de\nMehr: www.example.com"
    zenity --info --title="Support" --text="$TEXT"
}

# Hauptmenü anzeigen
show_menu() {
    if [[ "$MENU_LANG" == "de" ]]; then
        ACTION=$(zenity --list --title="SIBO 0.1 – Hauptmenü" \
            --column="Nummer" --column="Aktion" \
            1 "Scannen und OCR" \
            2 "OCR aus Datei" \
            3 "Spracheinstellungen" \
            4 "Version anzeigen" \
            5 "Support" \
            6 "Beenden")
    else
        ACTION=$(zenity --list --title="SIBO 0.1 – Main Menu" \
            --column="Number" --column="Action" \
            1 "Scan and OCR" \
            2 "OCR from File" \
            3 "Language Settings" \
            4 "Show Version" \
            5 "Support" \
            6 "Exit")
    fi

    case "$ACTION" in
        1) scan_image ;;
        2) run_ocr_from_file ;;
        3) change_language_settings ;;
        4) show_version_info ;;
        5) show_support_info ;;
        6) exit 0 ;;
        *) exit 0 ;;
    esac
}

# Hauptprogrammstart

# Wenn Konfigurationsdatei fehlt, zuerst Sprache wählen (legt config an)
if [[ ! -f "$CONFIG_FILE" ]]; then
    choose_language
fi

# Konfiguration laden (jetzt garantiert vorhanden)
load_config

# Hauptmenü anzeigen
while true; do
    show_menu
done

