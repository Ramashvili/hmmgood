#!/bin/sh

APP_BIN="$HOME/.local/bin"
APP_DESKTOP="$HOME/.local/share/applications"
APP_ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
MIME_DIR="$HOME/.local/share/mime/packages"

printf "\n"
printf "==========================================================\n"
printf "                  Uninstallation Preview                  \n"
printf "==========================================================\n"
printf "The following files will be removed from your system:\n\n"
printf "  1. Script:       %s/hmmgood\n" "$APP_BIN"
printf "  2. Icon:         %s/hmmgood.png\n" "$APP_ICON_DIR"
printf "  3. Desktop entry: %s/hmmgood.desktop\n" "$APP_DESKTOP"
printf "  4. MIME type:    %s/application-x-h-m-m.xml\n" "$MIME_DIR"
printf "==========================================================\n\n"

printf "Do you want to proceed with the uninstallation? [y/N] "
read -r CONFIRM
case "$CONFIRM" in
    [Yy]);;
    *)
        printf "Uninstallation cancelled.\n"
        exit 0
        ;;
esac

# Remove the files silently
rm -f "$APP_BIN/hmmgood"
rm -f "$APP_ICON_DIR/hmmgood.png"
rm -f "$APP_DESKTOP/hmmgood.desktop"
rm -f "$MIME_DIR/application-x-h-m-m.xml"

# Refresh system databases to clean up caches
update-mime-database "$HOME/.local/share/mime" >/dev/null 2>&1 || true
update-desktop-database "$APP_DESKTOP" >/dev/null 2>&1 || true

printf "Uninstallation complete!\n\n"
