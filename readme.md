# SIBO 0.1 - Features & Dependencies

## Features

### 1. Language Selection
- **Description**: Allows the user to choose the language for the menu and OCR language (German or English).
- **Languages Available**: 
  - Menu Language: English, German
  - OCR Language: English, German (Tesseract OCR)

### 2. OCR from File (Image or PDF)
- **Description**: Perform OCR (Optical Character Recognition) on an image or PDF file. The output is saved as a text file and an HTML file.
- **File Formats Supported**: PNG, JPEG, PDF
- **Output**: Text file and HTML file containing the recognized text.

### 3. Scanning and OCR
- **Description**: Scans an image using a scanner and applies OCR to the scanned image.
- **File Format**: PNG
- **Output**: Text file and HTML file containing the recognized text.

### 4. Language Settings
- **Description**: Change the OCR and menu language settings.

### 5. Version Information
- **Description**: Displays the version information of the program.

### 6. Support Information
- **Description**: Displays support contact information.

### 7. Exit the Application
- **Description**: Exit the program.

---

## Abhängigkeiten / Dependencies

### 1. `zenity`
- **Description**: Required for graphical dialogs.
- **Installation**:
  - On Debian/Ubuntu: `sudo apt-get install zenity`
  - On Fedora: `sudo dnf install zenity`

### 2. `tesseract`
- **Description**: OCR engine to perform text recognition on images.
- **Installation**:
  - On Debian/Ubuntu: `sudo apt-get install tesseract-ocr`
  - On Fedora: `sudo dnf install tesseract`

### 3. `pdftoppm`
- **Description**: Tool to convert PDF files into images for OCR processing.
- **Installation**:
  - On Debian/Ubuntu: `sudo apt-get install poppler-utils`
  - On Fedora: `sudo dnf install poppler-utils`

### 4. `scanimage` (Optional)
- **Description**: Required for scanning images using a scanner.
- **Installation**:
  - On Debian/Ubuntu: `sudo apt-get install sane-utils`
  - On Fedora: `sudo dnf install sane-utils`

---

## Features in German / Funktionen auf Deutsch

### 1. Sprachwahl
- **Beschreibung**: Ermöglicht dem Benutzer, die Sprache für das Menü und die OCR-Sprache auszuwählen (Deutsch oder Englisch).
- **Verfügbare Sprachen**: 
  - Menüsprache: Englisch, Deutsch
  - OCR-Sprache: Englisch, Deutsch (Tesseract OCR)

### 2. OCR aus Datei (Bild oder PDF)
- **Beschreibung**: Führt OCR (Optische Zeichenerkennung) auf einer Bild- oder PDF-Datei durch. Das Ergebnis wird als Textdatei und HTML-Datei gespeichert.
- **Unterstützte Dateiformate**: PNG, JPEG, PDF
- **Ausgabe**: Textdatei und HTML-Datei mit dem erkannten Text.

### 3. Scannen und OCR
- **Beschreibung**: Scannt ein Bild mit einem Scanner und wendet OCR auf das gescannte Bild an.
- **Dateiformat**: PNG
- **Ausgabe**: Textdatei und HTML-Datei mit dem erkannten Text.

### 4. Spracheinstellungen
- **Beschreibung**: Ändern der OCR- und Menüspracheinstellungen.

### 5. Versionsinfo
- **Beschreibung**: Zeigt die Versionsinformationen des Programms an.

### 6. Support-Info
- **Beschreibung**: Zeigt die Kontaktinformationen für den Support an.

### 7. Beenden
- **Beschreibung**: Beendet das Programm.

---

## Abhängigkeiten / Dependencies

### 1. `zenity`
- **Beschreibung**: Erforderlich für grafische Dialoge.
- **Installation**:
  - Auf Debian/Ubuntu: `sudo apt-get install zenity`
  - Auf Fedora: `sudo dnf install zenity`

### 2. `tesseract`
- **Beschreibung**: OCR-Engine zur Durchführung der Texterkennung auf Bildern.
- **Installation**:
  - Auf Debian/Ubuntu: `sudo apt-get install tesseract-ocr`
  - Auf Fedora: `sudo dnf install tesseract`

### 3. `pdftoppm`
- **Beschreibung**: Tool zum Konvertieren von PDF-Dateien in Bilder für die OCR-Verarbeitung.
- **Installation**:
  - Auf Debian/Ubuntu: `sudo apt-get install poppler-utils`
  - Auf Fedora: `sudo dnf install poppler-utils`

### 4. `scanimage` (Optional)
- **Beschreibung**: Erforderlich zum Scannen von Bildern mit einem Scanner.
- **Installation**:
  - Auf Debian/Ubuntu: `sudo apt-get install sane-utils`
  - Auf Fedora: `sudo dnf install sane-utils`

This markdown provides both English and German descriptions of the features and dependencies of your script. Let me know if you need further adjustments or additions!

