#!/usr/bin/env bash
# ==============================================================================
# 9M2PJU HamClock Installer (Open HamClock / OHB Edition)
# Compatible with: Linux (Debian, Ubuntu, Raspberry Pi OS, Arch, Fedora),
#                  macOS (Homebrew + XQuartz), and FreeBSD
# ==============================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}====================================================${NC}"
echo -e "${GREEN}           9M2PJU HamClock Installer             ${NC}"
echo -e "${GREEN}         (Open HamClock - OHB Edition)              ${NC}"
echo -e "${BLUE}====================================================${NC}"

OS="$(uname -s)"
ARCH="$(uname -m)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect Android Termux environment
IS_TERMUX=0
if [ -n "$TERMUX_VERSION" ] || [ -d "/data/data/com.termux" ] || { [ -n "$PREFIX" ] && [[ "$PREFIX" == *"com.termux"* ]]; }; then
    IS_TERMUX=1
fi

# Function to check command existence
has_cmd() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Install dependencies if missing
echo -e "\n${YELLOW}[1/4] Checking dependencies...${NC}"

if [ "$IS_TERMUX" = "1" ]; then
    echo -e "${GREEN}Detected Android (Termux) environment.${NC}"
    if has_cmd clang++ && has_cmd make && has_cmd git; then
        echo -e "${GREEN}Build dependencies (clang++, make, git) are already present.${NC}"
    else
        echo "Installing build dependencies via pkg..."
        pkg update -y
        pkg install -y clang make git curl
    fi
elif [ "$OS" = "Linux" ]; then
    if has_cmd g++ && has_cmd make && has_cmd pkg-config && has_cmd git; then
        echo -e "${GREEN}Build dependencies (g++, make, git) are already present.${NC}"
    elif has_cmd apt-get; then
        echo "Detected Debian/Ubuntu/Raspberry Pi OS system. Installing dependencies..."
        sudo apt-get update -y
        sudo apt-get install -y build-essential make g++ libx11-dev libgpiod-dev curl unzip git pkg-config
    elif has_cmd pacman; then
        echo "Detected Arch Linux / CachyOS / Manjaro system. Installing dependencies..."
        sudo pacman -Sy --noconfirm base-devel libx11 libgpiod curl unzip git
    elif has_cmd dnf; then
        echo "Detected Fedora / RHEL system. Installing dependencies..."
        sudo dnf install -y gcc-c++ make libX11-devel libgpiod-devel curl unzip git
    else
        echo "Please ensure g++, make, git, and libX11-dev are installed."
    fi
elif [ "$OS" = "Darwin" ]; then
    echo "Detected macOS."
    if ! has_cmd brew; then
        echo -e "${RED}Homebrew is required on macOS. Please install Homebrew first.${NC}"
        exit 1
    fi
    brew install make gcc git
    if ! [ -d "/opt/X11" ] && ! [ -d "/opt/local" ]; then
        echo "Installing XQuartz for X11 display support..."
        brew install --cask xquartz || true
    fi
elif [ "$OS" = "FreeBSD" ]; then
    echo "Detected FreeBSD."
    sudo pkg install -y gmake gcc libX11 libgpio curl unzip git
fi

# 2. Select build target & resolution
RAW_TARGET="${TARGET:-${RES:-${RESOLUTION:-$1}}}"

if [ -n "$RAW_TARGET" ]; then
    case "$RAW_TARGET" in
        *web*800*|web-800x480)    MAKE_TARGET="hamclock-web-800x480" ;;
        *web*1600*|web-1600x960)  MAKE_TARGET="hamclock-web-1600x960" ;;
        *web*2400*|web-2400x1440) MAKE_TARGET="hamclock-web-2400x1440" ;;
        *web*3200*|web-3200x1920) MAKE_TARGET="hamclock-web-3200x1920" ;;
        *fb*800*|fb0-800x480)     MAKE_TARGET="hamclock-fb0-800x480" ;;
        *fb*1600*|fb0-1600x960)   MAKE_TARGET="hamclock-fb0-1600x960" ;;
        *fb*2400*|fb0-2400x1440)  MAKE_TARGET="hamclock-fb0-2400x1440" ;;
        *fb*3200*|fb0-3200x1920)  MAKE_TARGET="hamclock-fb0-3200x1920" ;;
        *1600*|1600x960)          MAKE_TARGET="hamclock-1600x960" ;;
        *2400*|2400x1440)         MAKE_TARGET="hamclock-2400x1440" ;;
        *3200*|3200x1920)         MAKE_TARGET="hamclock-3200x1920" ;;
        *800*|800x480)            MAKE_TARGET="hamclock-800x480" ;;
        *)                        MAKE_TARGET="$RAW_TARGET" ;;
    esac
    echo -e "\n${CYAN}Using specified target: $MAKE_TARGET${NC}"
else
    if [ "$IS_TERMUX" = "1" ]; then
        echo -e "\n${YELLOW}[2/4] Select HamClock Build Target for Android / Termux:${NC}"
        echo "  1) Web Server Only - 1600x960 (Recommended for Tablets & HD Screens) [Default]"
        echo "  2) Web Server Only - 800x480 (Recommended for Phones & Compact Screens)"
        echo "  3) Web Server Only - 2400x1440 (2K Hi-DPI)"
        echo "  4) Web Server Only - 3200x1920 (4K Ultra-HD)"
        echo "  5) Desktop X11 - 1600x960 (Requires Termux:X11 or VNC)"
        echo "  6) Desktop X11 - 800x480 (Requires Termux:X11 or VNC)"

        read -r -p "Enter choice [1-6, default: 1]: " TARGET_CHOICE
        TARGET_CHOICE=${TARGET_CHOICE:-1}

        case "$TARGET_CHOICE" in
            1) MAKE_TARGET="hamclock-web-1600x960" ;;
            2) MAKE_TARGET="hamclock-web-800x480" ;;
            3) MAKE_TARGET="hamclock-web-2400x1440" ;;
            4) MAKE_TARGET="hamclock-web-3200x1920" ;;
            5) MAKE_TARGET="hamclock-1600x960" ;;
            6) MAKE_TARGET="hamclock-800x480" ;;
            *) MAKE_TARGET="hamclock-web-1600x960" ;;
        esac
    else
        echo -e "\n${YELLOW}[2/4] Select HamClock Build Target & Resolution:${NC}"
        echo "  1) Desktop X11 - 800x480 (Standard Desktop GUI) [Default]"
        echo "  2) Desktop X11 - 1600x960 (Large Desktop GUI)"
        echo "  3) Desktop X11 - 2400x1440 (High-DPI Desktop GUI)"
        echo "  4) Desktop X11 - 3200x1920 (Huge 4K Desktop GUI)"
        echo "  5) Web Server Only - 800x480 (Headless / Remote Browser Access)"
        echo "  6) Web Server Only - 1600x960 (Large Headless)"
        echo "  7) Raspberry Pi /dev/fb0 - 800x480 (Standalone Kiosk)"
        echo "  8) Raspberry Pi /dev/fb0 - 1600x960 (Large Standalone Kiosk)"

        read -r -p "Enter choice [1-8, default: 1]: " TARGET_CHOICE
        TARGET_CHOICE=${TARGET_CHOICE:-1}

        case "$TARGET_CHOICE" in
            1) MAKE_TARGET="hamclock-800x480" ;;
            2) MAKE_TARGET="hamclock-1600x960" ;;
            3) MAKE_TARGET="hamclock-2400x1440" ;;
            4) MAKE_TARGET="hamclock-3200x1920" ;;
            5) MAKE_TARGET="hamclock-web-800x480" ;;
            6) MAKE_TARGET="hamclock-web-1600x960" ;;
            7) MAKE_TARGET="hamclock-fb0-800x480" ;;
            8) MAKE_TARGET="hamclock-fb0-1600x960" ;;
            *) MAKE_TARGET="hamclock-800x480" ;;
        esac
    fi
fi

# 3. Obtain Source & Build
echo -e "\n${YELLOW}[3/4] Compiling $MAKE_TARGET...${NC}"

CLEANUP_BUILD_DIR=0
if [ -f "$SCRIPT_DIR/Makefile" ]; then
    BUILD_DIR="$SCRIPT_DIR"
    cd "$BUILD_DIR"
else
    BUILD_DIR="$(mktemp -d /tmp/hamclock-build-XXXXXX)"
    echo "Fetching latest source into temporary directory $BUILD_DIR..."
    git clone --depth 1 https://github.com/9M2PJU/9M2PJU-HamClock-Installer.git "$BUILD_DIR"
    cd "$BUILD_DIR"
    CLEANUP_BUILD_DIR=1
fi

make clean
NPROCS=1
if has_cmd nproc; then
    NPROCS=$(nproc)
elif has_cmd sysctl; then
    NPROCS=$(sysctl -n hw.ncpu || echo 1)
fi

if [ "$IS_TERMUX" = "1" ]; then
    for p in "$BUILD_DIR"/termux/patches/*.patch; do
        if [ -f "$p" ]; then
            patch -p1 -N < "$p" || true
        fi
    done
    clang -c "$BUILD_DIR/termux/disable-fdsan.c" -o "$BUILD_DIR/termux/disable-fdsan.o" 2>/dev/null || true
    make "$MAKE_TARGET" CXX="clang++" LDXXFLAGS="-LArduinoLib -LwsServer -Lzlib-hc -g -pthread $BUILD_DIR/termux/disable-fdsan.o -ldl" -j"$NPROCS"
    if [ "$CLEANUP_BUILD_DIR" -eq 0 ]; then
        for p in "$BUILD_DIR"/termux/patches/*.patch; do
            if [ -f "$p" ]; then
                patch -p1 -R -s < "$p" || true
            fi
        done
    fi
else
    make "$MAKE_TARGET" -j"$NPROCS"
fi

# 4. Install binary and desktop shortcuts
echo -e "\n${YELLOW}[4/4] Installing HamClock...${NC}"
if [ "$IS_TERMUX" = "1" ]; then
    BIN_DEST="${PREFIX:-/data/data/com.termux/files/usr}/bin"
elif [ "$(id -u)" -eq 0 ]; then
    BIN_DEST="/usr/local/bin"
else
    BIN_DEST="$HOME/.local/bin"
fi

mkdir -p "$BIN_DEST"
cp "$MAKE_TARGET" "$BIN_DEST/hamclock"
chmod +x "$BIN_DEST/hamclock"

# Install desktop shortcut on standard Linux (non-Termux)
if [ "$OS" = "Linux" ] && [ "$IS_TERMUX" = "0" ]; then
    mkdir -p "$HOME/.local/share/icons" "$HOME/.local/share/applications"
    if [ -f "$BUILD_DIR/deploy/hamclock.png" ]; then
        cp "$BUILD_DIR/deploy/hamclock.png" "$HOME/.local/share/icons/"
    elif [ -f "$BUILD_DIR/hamclock.png" ]; then
        cp "$BUILD_DIR/hamclock.png" "$HOME/.local/share/icons/"
    fi
    if [ -f "$BUILD_DIR/deploy/hamclock.desktop" ]; then
        cp "$BUILD_DIR/deploy/hamclock.desktop" "$HOME/.local/share/applications/"
        sed -i "s|/usr/local/bin/hamclock|$BIN_DEST/hamclock|g" "$HOME/.local/share/applications/hamclock.desktop" || true
    elif [ -f "$BUILD_DIR/hamclock.desktop" ]; then
        cp "$BUILD_DIR/hamclock.desktop" "$HOME/.local/share/applications/"
        sed -i "s|/usr/local/bin/hamclock|$BIN_DEST/hamclock|g" "$HOME/.local/share/applications/hamclock.desktop" || true
    fi
fi

# Cleanup temp build dir if created
if [ "$CLEANUP_BUILD_DIR" = "1" ]; then
    rm -rf "$BUILD_DIR"
fi

echo -e "\n${GREEN}====================================================${NC}"
echo -e "${GREEN}  Installation Complete!                           ${NC}"
echo -e "${GREEN}  Target:          $MAKE_TARGET                    ${NC}"
echo -e "${GREEN}  Binary Path:     $BIN_DEST/hamclock              ${NC}"
echo -e "${GREEN}  Default Backend: ohb.hamclock.app:80             ${NC}"
echo -e "${GREEN}====================================================${NC}"

if [ "$IS_TERMUX" = "1" ]; then
    echo -e "\n${CYAN}📱 Android / Termux Quick Start:${NC}"
    echo -e "  1. Start HamClock background server:"
    echo -e "     ${YELLOW}hamclock -k &${NC}"
    echo -e "  2. Open your Android browser (Chrome / Firefox):"
    echo -e "     ${YELLOW}http://localhost:8081/live.html${NC}"
    echo -e "  3. In Chrome menu (⋮) -> Tap 'Add to Home screen' for full-screen touch control!\n"
else
    echo -e "You can start HamClock by running:\n  ${YELLOW}hamclock${NC}\n"
fi
