# HamClock for Android (Termux)

This directory contains standalone installers, build helpers, and service scripts to build and run **HamClock** natively on Android devices via **Termux**, without altering any upstream source code.

## Quick One-Liner Install

Open Termux on Android and paste:

```bash
pkg update -y && pkg install -y curl && curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/termux/install.sh | bash
```

## Files in this Directory

| File | Description |
| :--- | :--- |
| [`install.sh`](install.sh) | Full-featured interactive installer for Termux (packages, build, path setup) |
| [`build.sh`](build.sh) | Standalone build helper passing `CXX=clang++` to GNU make |
| [`disable-fdsan.c`](disable-fdsan.c) | Runtime constructor to disable Android Bionic libc `fdsan` socket aborts |
| [`patches/`](patches/) | Standalone patches applied only during the Termux build |
| [`hamclock-service.sh`](hamclock-service.sh) | 24/7 background launcher with automatic `termux-wake-lock` |

## How It Works

HamClock is built using Clang with `-D_WEB_ONLY` target (e.g. `hamclock-web-1600x960`), enabling it to run as a high-performance, standalone web daemon. 

### Accessing the Touch Interface
- **Interactive Touch Screen**: `http://localhost:8081/live.html` (Port 8081)
- **LAN Remote Access**: `http://<PHONE-IP>:8081/live.html`
- **Read-Only Monitor Screen**: `http://localhost:8082/live.html` (Port 8082)
- **Backend RESTful API**: `http://localhost:8080/` (Port 8080)

### 24/7 Background Running & Wake Lock
```bash
termux-wake-lock
hamclock -k &
```
