#!/bin/sh

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root. Please use sudo or log in as root."
  exit 1
fi

# Check if Git is installed
if ! command -v git &>/dev/null; then
    echo "Git is not installed."
    echo "Please install git if you want to pull default yamls."
else
    echo "Git is already installed. It will pull default yamls."
fi

# Variables
RELEASES_URL="https://github.com/sorenisanerd/gotty/releases"
GOTTY_TARGET_VERSION="v1.5.0"
BLACKDAGGER_RELEASES_URL="https://github.com/erdemozgen/blackdagger/releases"
FILE_BASENAME="blackdagger"
TMPDIR=$(mktemp -d)

# Determine OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$ARCH" in
    x86_64) ARCH="amd64" ;;
    arm*) ARCH="arm" ;;
    aarch64) ARCH="arm64" ;;
    i386) ARCH="386" ;;
    i686) ARCH="386" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Download and install Gotty
TAR_FILE="gotty_${GOTTY_TARGET_VERSION}_${OS}_${ARCH}.tar.gz"
DOWNLOAD_URL="$RELEASES_URL/download/$GOTTY_TARGET_VERSION/$TAR_FILE"
DOWNLOAD_PATH="${TMPDIR}/${TAR_FILE}"

echo "Downloading Gotty from $DOWNLOAD_URL..."
curl -sfLo "$DOWNLOAD_PATH" "$DOWNLOAD_URL"

if [ ! -f "$DOWNLOAD_PATH" ]; then
    echo "Failed to download Gotty."
    exit 1
fi

echo "Extracting Gotty..."
tar -xzf "$DOWNLOAD_PATH" -C "$TMPDIR"

if [ ! -f "${TMPDIR}/gotty" ]; then
    echo "Failed to extract Gotty. The binary is not found."
    exit 1
fi

mv "${TMPDIR}/gotty" /usr/bin/
echo "Gotty has been installed to /usr/bin."

# Download and install Blackdagger
VERSION=$(curl -sfL -o /dev/null -w %{url_effective} "$BLACKDAGGER_RELEASES_URL/latest" | rev | cut -f1 -d'/' | rev)

if [ -z "$VERSION" ]; then
    echo "Unable to get Blackdagger version."
    exit 1
fi

TAR_FILE="${TMPDIR}/${FILE_BASENAME}_${OS}_${ARCH}.tar.gz"
DOWNLOAD_URL="$BLACKDAGGER_RELEASES_URL/download/$VERSION/${FILE_BASENAME}_${VERSION:1}_${OS}_${ARCH}.tar.gz"

echo "Downloading Blackdagger from $DOWNLOAD_URL..."
curl -sfLo "$TAR_FILE" "$DOWNLOAD_URL"

if [ ! -f "$TAR_FILE" ]; then
    echo "Failed to download Blackdagger."
    exit 1
fi

echo "Extracting Blackdagger..."
tar -xf "$TAR_FILE" -C "$TMPDIR"

if [ ! -f "${TMPDIR}/blackdagger" ]; then
    echo "Failed to extract Blackdagger. The binary is not found."
    exit 1
fi

# Install Blackdagger
mv "${TMPDIR}/blackdagger" /usr/bin/
echo "Blackdagger has been installed to /usr/bin."

# Cleanup
rm -rf "$TMPDIR"

echo "Installation completed successfully."
