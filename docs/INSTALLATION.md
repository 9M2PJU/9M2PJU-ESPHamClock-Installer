# 🚀 HamClock Installation Guide

Comprehensive installation instructions for **HamClock (Open HamClock / OHB Edition)** across all supported operating systems and hardware platforms.

---

## 📑 Table of Contents
1. [One-Liner Quick Install (Linux/macOS/Android)](#1-one-liner-quick-install)
2. [Pre-Built Linux Packages (AUR, .deb, .rpm, .AppImage, Flatpak)](#2-pre-built-linux-packages-aur-deb-rpm-appimage-flatpak)
3. [Windows Installation (WSL2 & Docker)](#3-windows-installation-wsl2--docker)
4. [Android Installation (Termux)](#4-android-installation-termux)
5. [Docker & Containerized Setup](#5-docker--containerized-setup)
6. [Raspberry Pi & Inovato Quadra Setup](#6-raspberry-pi--inovato-quadra-setup)
7. [Linux Native Compilation (Debian, Ubuntu, Arch, Fedora)](#7-linux-native-compilation)
8. [macOS Installation (Apple Silicon & Intel)](#8-macos-installation)
9. [FreeBSD Installation](#9-freebsd-installation)
10. [Systemd Autostart & Background Services](#10-systemd-autostart--background-services)

---

## 1. One-Liner Quick Install

The universal installer automatically detects your operating system, installs any missing build packages, compiles HamClock, and sets up desktop shortcuts.

```bash
curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash
```

### Selecting Resolution / Target Non-Interactively:
```bash
# Large Desktop (1600x960)
TARGET=1600x960 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash

# Headless Web Server (1600x960)
TARGET=web-1600x960 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash

# Raspberry Pi Touchscreen Framebuffer (/dev/fb0)
TARGET=fb0-800x480 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash
```

---

## 2. Pre-Built Linux Packages (AUR, .deb, .rpm, .AppImage, Flatpak)

For quick installation without building from source, download pre-compiled packages directly from [GitHub Releases](https://github.com/9M2PJU/9M2PJU-HamClock-Installer/releases) or install via package managers:

### 📦 Snap Store (Ubuntu / Universal Linux)
```bash
sudo snap install hamclock
```

### 🏹 Arch Linux / Manjaro / EndeavourOS / CachyOS (AUR)
```bash
# Using yay
yay -S hamclock-git

# Using paru
paru -S hamclock-git
```

### 🐧 Debian / Ubuntu / Raspberry Pi OS (`.deb`)
Supports `amd64`, `arm64` (RPi 4/5), and `armhf` (RPi 2/3, 32-bit):
```bash
# Download and install
sudo dpkg -i hamclock_4.29-1_amd64.deb    # or _arm64.deb / _armhf.deb
sudo apt-get install -f                   # resolve dependencies
```

### 🎩 Fedora / RHEL / openSUSE (`.rpm`)
Supports `x86_64`, `aarch64`, and `armhfp`:
```bash
sudo rpm -Uvh hamclock-4.29-1.x86_64.rpm  # or .aarch64.rpm
```

### 🚀 Universal AppImage (Runs on ANY Linux distro without installation)
Supports `x86_64`, `aarch64`, and `armhf`:
```bash
chmod +x HamClock-4.29-x86_64.AppImage
./HamClock-4.29-x86_64.AppImage

# Launch with specific resolution
./HamClock-4.29-x86_64.AppImage -r 1600x960
```

### 📦 Flatpak (Flathub)
```bash
flatpak install flathub my.hamradio.HamClock
flatpak run my.hamradio.HamClock
```

---

## 3. Windows Installation (WSL2 & Docker)

See the full [Windows Installation Guide](WINDOWS.md) for complete instructions.

### 1-Click Automated PowerShell Installer:
```powershell
irm https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/scripts/install.ps1 | iex
```

---

## 4. Android Installation (Termux)

See the full [Android & Termux Guide](ANDROID.md) for detailed battery, kiosk, and autostart optimizations.

### 1-Line Automated Termux Installer:
Open the **Termux** app and run:
```bash
pkg update -y && pkg install -y curl && bash -c "$(curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/termux/install.sh)"
```

### Quick Start:
1. Prevent Android from sleeping (disable Battery Saver) and start HamClock:
   ```bash
   termux-wake-lock
   hamclock -k &
   ```
   *(Ensure Android **Settings ➔ Apps ➔ Termux ➔ Battery** is set to **"Unrestricted"**)*.
2. For the best **Full-Screen & Auto-Fit** display, install [**Fully Kiosk Browser**](https://play.google.com/store/apps/details?id=de.ozerov.fully&hl=en) from Google Play and open:
   ```text
   http://localhost:8081/live.html
   ```
   *(Or open in Chrome, Brave, or Firefox).*

---

## 5. Docker & Containerized Setup

```bash
curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash
```

### Selecting Resolution / Target Non-Interactively:
```bash
# Large Desktop (1600x960)
TARGET=1600x960 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash

# Headless Web Server (1600x960)
TARGET=web-1600x960 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash

# Raspberry Pi Touchscreen Framebuffer (/dev/fb0)
TARGET=fb0-800x480 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash
```

---

## 2. Docker & Containerized Setup

For servers, NAS devices (Synology, TrueNAS, Unraid), and headless Raspberry Pis.

### Option A: 1-Line Docker Automated Deployment
```bash
curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install-docker.sh | bash
```

### Option B: Docker Compose
Create a `docker-compose.yml` file:
```yaml
services:
  hamclock:
    image: ghcr.io/9m2pju/hamclock:latest
    container_name: hamclock
    restart: unless-stopped
    ports:
      - "8080:8080" # REST API & Screenshot (/live.png)
      - "8081:8081" # Real-time Interactive Web UI (/live.html)
      - "8082:8082" # Read-Only Web Monitor
    environment:
      - RESOLUTION=1600x960  # Options: 800x480, 1600x960, 2400x1440, 3200x1920
      - EXTRA_ARGS=-k
    volumes:
      - hamclock_data:/home/hamclock/.hamclock

volumes:
  hamclock_data:
```
Launch with:
```bash
docker compose up -d
```

---

## 3. Raspberry Pi & Inovato Quadra Setup

### Standalone Kiosk Mode (Direct Linux Framebuffer)
If you are running a Raspberry Pi or Inovato Quadra without a heavy desktop environment (e.g. Raspberry Pi OS Lite):
```bash
sudo apt update && sudo apt install -y build-essential make g++ libgpiod-dev curl
git clone https://github.com/9M2PJU/9M2PJU-HamClock-Installer.git
cd 9M2PJU-HamClock-Installer
make hamclock-fb0-800x480 -j$(nproc)
sudo make install
```
Start in kiosk mode:
```bash
sudo hamclock -k -f on
```

---

## 4. Linux Native Compilation

### Debian / Ubuntu / Mint / Raspberry Pi OS Desktop
```bash
sudo apt update
sudo apt install -y build-essential make g++ libx11-dev libgpiod-dev curl unzip pkg-config
git clone https://github.com/9M2PJU/9M2PJU-HamClock-Installer.git
cd 9M2PJU-HamClock-Installer
make hamclock-1600x960 -j$(nproc)
sudo make install
```

### Arch Linux / CachyOS / Manjaro
```bash
sudo pacman -Syu --needed base-devel libx11 libgpiod curl unzip
git clone https://github.com/9M2PJU/9M2PJU-HamClock-Installer.git
cd 9M2PJU-HamClock-Installer
make hamclock-1600x960 -j$(nproc)
sudo make install
```

### Fedora / RHEL / AlmaLinux
```bash
sudo dnf install -y gcc-c++ make libX11-devel libgpiod-devel curl unzip
git clone https://github.com/9M2PJU/9M2PJU-HamClock-Installer.git
cd 9M2PJU-HamClock-Installer
make hamclock-1600x960 -j$(nproc)
sudo make install
```

---

## 5. macOS Installation

Requires [Homebrew](https://brew.sh/) and [XQuartz](https://www.xquartz.org/):

```bash
brew install make gcc
brew install --cask xquartz
git clone https://github.com/9M2PJU/9M2PJU-HamClock-Installer.git
cd 9M2PJU-HamClock-Installer
make hamclock-1600x960 -j$(sysctl -n hw.ncpu)
sudo make install
```

---

## 6. FreeBSD Installation

```bash
sudo pkg install -y gmake gcc libX11 libgpio curl unzip
git clone https://github.com/9M2PJU/9M2PJU-HamClock-Installer.git
cd 9M2PJU-HamClock-Installer
gmake hamclock-1600x960
sudo gmake install
```

---

## 7. Systemd Autostart & Background Services

### Desktop Autostart on Login
```bash
mkdir -p ~/.config/autostart
cp hamclock.desktop ~/.config/autostart/
chmod +x ~/.config/autostart/hamclock.desktop
```

### Headless Web Server Systemd Service
Create `/etc/systemd/system/hamclock.service`:
```ini
[Unit]
Description=HamClock Web Server
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=pi
ExecStart=/usr/local/bin/hamclock -k -d /home/pi/.hamclock
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```
Enable and start the service:
```bash
sudo systemctl daemon-reload
sudo systemctl enable --now hamclock
sudo systemctl status hamclock
```
