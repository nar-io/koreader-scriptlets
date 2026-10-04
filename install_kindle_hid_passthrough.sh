#!/bin/sh
# Name: HID Passthrough Installer
# Author: nario
# Description: Installs the complete HID Passthrough suite
# Icon:

REPO="zampierilucas/kindle-hid-passthrough"
TARBALL_NAME="kindle-hid-passthrough-armv7.tar.xz"
WORK_DIR="/mnt/us/kbm_tmp"
TMP_DIR="/tmp/kbm_install"

echo "============================================"
echo "  Kindle HID Passthrough Installer"
echo "============================================"
echo "Starting installation..."

echo "Checking network connection..."
if ping -c 1 -W 5 github.com > /dev/null 2>&1; then
    echo "Network connection OK."
else
    echo "ERROR: No network connection! Connect to WiFi and try again."
    sleep 5
    exit 1
fi

echo "Checking for the latest version..."
RELEASE_URL="https://api.github.com/repos/${REPO}/releases/latest"

if command -v curl > /dev/null 2>&1; then
    DOWNLOADER="curl"
else
    echo "ERROR: curl not found!"
    sleep 5
    exit 1
fi

RELEASE_JSON=$(curl -s "$RELEASE_URL" 2>/dev/null)
DOWNLOAD_URL=$(echo "$RELEASE_JSON" | grep -o '"browser_download_url"[[:space:]]*:[[:space:]]*"[^"]*'"$TARBALL_NAME"'"' | head -1 | grep -o 'https://[^"]*')

if [ "$DOWNLOAD_URL" = "" ]; then
    DOWNLOAD_URL="https://github.com/${REPO}/releases/latest/download/${TARBALL_NAME}"
    echo "Failed to fetch URL from API, trying direct download link..."
fi

echo "Downloading release..."
mkdir -p "$TMP_DIR"
curl -sL "$DOWNLOAD_URL" --output "${TMP_DIR}/${TARBALL_NAME}"

if [ ! -s "${TMP_DIR}/${TARBALL_NAME}" ]; then
    echo "ERROR: Download failed! Check your internet connection."
    sleep 5
    exit 1
fi

echo "Download complete. Extracting archive..."
mkdir -p "$WORK_DIR"
tar -xf "${TMP_DIR}/${TARBALL_NAME}" -C "$WORK_DIR"

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to extract archive!"
    sleep 5
    exit 1
fi

echo "Archive extracted. Running installer script..."
FOUND_INSTALL=$(find "$WORK_DIR" -name "install.sh" -type f 2>/dev/null | head -1)

if [ "$FOUND_INSTALL" != "" ]; then
    chmod +x "$FOUND_INSTALL"
    sh "$FOUND_INSTALL" installAll
    INSTALL_RESULT=$?
else
    echo "ERROR: install.sh not found!"
    INSTALL_RESULT=1
fi

echo "Cleaning up temporary files..."
rm -rf "$TMP_DIR" "$WORK_DIR" 2>/dev/null

if [ "$INSTALL_RESULT" -eq 0 ] || [ -d "/mnt/us/kindle_hid_passthrough" ]; then
    echo "============================================"
    echo "  [V] INSTALLATION SUCCESSFUL!"
    echo "============================================"
else
    echo "============================================"
    echo "  [X] INSTALLATION FAILED!"
    echo "============================================"
fi

echo "Done! Rebooting in 5 seconds..."
sleep 5
reboot
