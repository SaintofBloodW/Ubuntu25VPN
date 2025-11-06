# Ubuntu25VPN

chmod +x ./install.sh

or as one liner: 

TEMP_DIR=$(mktemp -d) && cd "$TEMP_DIR" && curl -LO "https://nl.archive.ubuntu.com/ubuntu/pool/main/w/webkit2gtk/libwebkit2gtk-4.0-37_2.48.7-0ubuntu0.22.04.2_amd64.deb" && curl -LO "https://nl.archive.ubuntu.com/ubuntu/pool/main/w/webkit2gtk/libjavascriptcoregtk-4.0-18_2.48.7-0ubuntu0.22.04.2_amd64.deb" && curl -LO "https://cdimage.debian.org/mirror/ubuntu/ubuntu/pool/main/i/icu/libicu70_70.1-2_amd64.deb" && sudo dpkg -i ./*.deb && sudo apt update && sudo apt install -y bzip2 libgtkmm-3.0-1v5 && cd .. && rm -rf "$TEMP_DIR"
