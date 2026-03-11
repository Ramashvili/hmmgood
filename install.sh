#!/bin/sh

APP_BIN="$HOME/.local/bin"
APP_DESKTOP="$HOME/.local/share/applications"
APP_ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
MIME_DIR="$HOME/.local/share/mime/packages"

printf "\n"
printf "==========================================================\n"
printf "                   Installation Preview                   \n"
printf "==========================================================\n"
printf "The following changes will be made to your system:\n\n"
printf "  1. Script copied to:     %s/hmmgood\n" "$APP_BIN"
printf "  2. Icon copied to:       %s/hmmgood.png\n" "$APP_ICON_DIR"
printf "  3. Desktop entry:        %s/hmmgood.desktop\n" "$APP_DESKTOP"
printf "  4. MIME type copied to:  %s/application-x-h-m-m.xml\n" "$MIME_DIR"
printf "==========================================================\n\n"

printf "Do you want to proceed with the installation? [y/N] "
read -r CONFIRM
case "$CONFIRM" in
    [Yy]);;
    *)
        printf "Installation cancelled.\n"
        exit 0
        ;;
esac

mkdir -p "$APP_BIN" "$APP_DESKTOP" "$APP_ICON_DIR" "$MIME_DIR"

cp hmmgood "$APP_BIN/hmmgood"
cp hmmgood.png "$APP_ICON_DIR/hmmgood.png"
chmod +x "$APP_BIN/hmmgood"
cp hmmgood.desktop "$APP_DESKTOP/"
cp application-x-h-m-m.xml "$MIME_DIR/application-x-h-m-m.xml"

update-mime-database "$HOME/.local/share/mime" >/dev/null 2>&1 || true
update-desktop-database "$APP_DESKTOP" >/dev/null 2>&1 || true
xdg-mime default hmmgood.desktop application/x-hmmgood >/dev/null 2>&1 || true

printf "Installation complete!\n\n"
! command -v h-m-m    >/dev/null 2>&1 && printf "  - h-m-m is not installed. Please install it from the nadrad/h-m-m repository on GitHub.\n"
! command -v whiptail >/dev/null 2>&1 && printf "  - whiptail is not installed. Please install whiptail.\n"
printf "\n"
printf "You can now launch 'hmmgood' from your application menu or terminal\n"
printf "You can open a .hmm file from a file browser.\n"
printf "You may need to log out and log back in for changes to take effect.\n"
