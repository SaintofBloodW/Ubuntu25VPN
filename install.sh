#!/bin/bash
# This script downloads and installs dependencies for Pulse Secure

# Exit immediately if a command exits with a non-zero status
set -e

# --- Configuration ---
# List of .deb files to download
DEB_URLS=(
    "https://nl.archive.ubuntu.com/ubuntu/pool/main/w/webkit2gtk/libwebkit2gtk-4.0-37_2.48.7-0ubuntu0.22.04.2_amd64.deb"
    "https://nl.archive.ubuntu.com/ubuntu/pool/main/w/webkit2gtk/libjavascriptcoregtk-4.0-18_2.48.7-0ubuntu0.22.04.2_amd64.deb"
    "https://cdimage.debian.org/mirror/ubuntu/ubuntu/pool/main/i/icu/libicu70_70.1-2_amd64.deb"
)

# Packages to install via apt
APT_PACKAGES="bzip2 libgtkmm-3.0-1v5"

# --- Script Logic ---
echo "Creating a temporary directory for downloads..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

echo "Downloading required .deb packages..."
for url in "${DEB_URLS[@]}"; do
    echo "Downloading $url"
    curl -LO "$url"
done

echo "Installing downloaded .deb packages..."
# We use *.deb to install all downloaded files
sudo dpkg -i ./*.deb

echo "Installing apt packages: $APT_PACKAGES..."
sudo apt update
sudo apt install -y $APT_PACKAGES

echo "Running Pulse Secure CEF setup..."
# Check if the file exists before trying to run it
if [ -f /opt/pulsesecure/bin/setup_cef.sh ]; then
    sudo /opt/pulsesecure/bin/setup_cef.sh install
else
    echo "ERROR: /opt/pulsesecure/bin/setup_cef.sh not found."
    echo "Please ensure Pulse Secure is installed in /opt/pulsesecure first."
    exit 1
fi

echo "Cleaning up downloaded files..."
cd ..
rm -rf "$TEMP_DIR"

echo "Setup complete."
