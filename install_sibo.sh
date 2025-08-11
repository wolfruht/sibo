#!/bin/bash

# Installationspfade
INSTALL_DIR="/opt/sibo"
SCRIPT_NAME="sibo.sh"
TARGET_SCRIPT="$INSTALL_DIR/sibo.sh"
SYMLINK="/usr/local/bin/sibo"
DESKTOP_ENTRY_PATH="$HOME/Desktop/SIBO.desktop"

# Funktion: Prüfe, ob ein Befehl vorhanden ist
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Funktion: Fehlende Pakete installieren (Debian/Ubuntu basiert)
install_package_if_missing() {
    PKG="$1"
    if ! dpkg -s "$PKG" &>/dev/null; then
        echo "Installiere $PKG..."
        sudo apt-get update
        sudo apt-get install -y "$PKG"
    else
        echo "$PKG ist bereits installiert."
    fi
}

echo "🔧 Starte Installation von SIBO..."

# Prüfe und installiere Abhängigkeiten
install_package_if_missing zenity
install_package_if_missing tesseract-ocr
install_package_if_missing poppler-utils
install_package_if_missing sane-utils

# Sicherstellen, dass die Hauptdatei existiert
if [[ ! -f "$SCRIPT_NAME" ]]; then
    echo "❌ Fehler: Datei '$SCRIPT_NAME' wurde nicht gefunden im aktuellen Verzeichnis!"
    exit 1
fi

# Erstelle Installationsverzeichnis falls nicht vorhanden
echo "📁 Erstelle Installationsverzeichnis $INSTALL_DIR..."
sudo mkdir -p "$INSTALL_DIR"

# Kopiere das Skript nach /opt/sibo
echo "📄 Kopiere $SCRIPT_NAME nach $TARGET_SCRIPT..."
sudo cp "$SCRIPT_NAME" "$TARGET_SCRIPT"
sudo chmod +x "$TARGET_SCRIPT"

# Erstelle symbolischen Link für einfachen Zugriff im Terminal
echo "🔗 Erstelle Symlink nach $SYMLINK..."
sudo ln -sf "$TARGET_SCRIPT" "$SYMLINK"

# Desktop-Verknüpfung erstellen
echo "🖥️  Erstelle Desktop-Verknüpfung unter $DESKTOP_ENTRY_PATH..."

cat <<EOF > "$DESKTOP_ENTRY_PATH"
[Desktop Entry]
Name=SIBO OCR
Comment=OCR Tool für Bilder, PDF und Scanner
Exec=$TARGET_SCRIPT
Icon=utilities-text-editor
Terminal=false
Type=Application
Categories=Utility;
EOF

chmod +x "$DESKTOP_ENTRY_PATH"

echo -e "\n✅ Installation abgeschlossen!"
echo "👉 Starte SIBO mit dem Befehl: sibo"
echo "📁 Installationsverzeichnis: $INSTALL_DIR"
echo "🖥️  Desktop-Verknüpfung erstellt: $DESKTOP_ENTRY_PATH"

🧪 Verwendung


