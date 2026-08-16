# 🚀 HamClock Installation Guide

Comprehensive installation instructions for **HamClock (Open HamClock / OHB Edition)** across all supported operating systems and hardware platforms.

---

## 📑 Table of Contents
1. [One-Liner Quick Install (Recommended)](#1-one-liner-quick-install)
2. [Docker & Containerized Setup](#2-docker--containerized-setup)
3. [Raspberry Pi & Inovato Quadra Setup](#3-raspberry-pi--inovato-quadra-setup)
4. [Linux Native Compilation (Debian, Ubuntu, Arch, Fedora)](#4-linux-native-compilation)
5. [macOS Installation (Apple Silicon & Intel)](#5-macos-installation)
6. [FreeBSD Installation](#6-freebsd-installation)
7. [Systemd Autostart & Background Services](#7-systemd-autostart--background-services)

---

## 1. One-Liner Quick Install

The universal installer automatically detects your operating system, installs any missing build packages, compiles HamClock, and sets up desktop shortcuts.

```bash
curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-ESPHamClock-Installer/main/install.sh | bash
```

### Selecting Resolution / Target Non-Interactively:
```bash
# Large Desktop (1600x960)
TARGET=1600x960 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-ESPHamClock-Installer/main/install.sh | bash

# Headless Web Server (1600x960)
TARGET=web-1600x960 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-ESPHamClock-Installer/main/install.sh | bash

# Raspberry Pi Touchscreen Framebuffer (/dev/fb0)
TARGET=fb0-800x480 curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-ESPHamClock-Installer/main/install.sh | bash
```

---

## 2. Docker & Containerized Setup

For servers, NAS devices (Synology, TrueNAS, Unraid), and headless Raspberry Pis.

### Option A: 1-Line Docker Automated Deployment
```bash
curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-ESPHamClock-Installer/main/install-docker.sh | bash
```

### Option B: Docker Compose
Create a `docker-compose.yml` file:
```yaml
services:
  hamclock:
    image: ghcr.io/9m2pju/esphamclock:latest
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
git clone https://github.com/9M2PJU/9M2PJU-ESPHamClock-Installer.git
cd 9M2PJU-ESPHamClock-Installer
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
git clone https://github.com/9M2PJU/9M2PJU-ESPHamClock-Installer.git
cd 9M2PJU-ESPHamClock-Installer
make hamclock-1600x960 -j$(nproc)
sudo make install
```

### Arch Linux / CachyOS / Manjaro
```bash
sudo pacman -Syu --needed base-devel libx11 libgpiod curl unzip
git clone https://github.com/9M2PJU/9M2PJU-ESPHamClock-Installer.git
cd 9M2PJU-ESPHamClock-Installer
make hamclock-1600x960 -j$(nproc)
sudo make install
```

### Fedora / RHEL / AlmaLinux
```bash
sudo dnf install -y gcc-c++ make libX11-devel libgpiod-devel curl unzip
git clone https://github.com/9M2PJU/9M2PJU-ESPHamClock-Installer.git
cd 9M2PJU-ESPHamClock-Installer
make hamclock-1600x960 -j$(nproc)
sudo make install
```

---

## 5. macOS Installation

Requires [Homebrew](https://brew.sh/) and [XQuartz](https://www.xquartz.org/):

```bash
brew install make gcc
brew install --cask xquartz
git clone https://github.com/9M2PJU/9M2PJU-ESPHamClock-Installer.git
cd 9M2PJU-ESPHamClock-Installer
make hamclock-1600x960 -j$(sysctl -n hw.ncpu)
sudo make install
```

---

## 6. FreeBSD Installation

```bash
sudo pkg install -y gmake gcc libX11 libgpio curl unzip
git clone https://github.com/9M2PJU/9M2PJU-ESPHamClock-Installer.git
cd 9M2PJU-ESPHamClock-Installer
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
