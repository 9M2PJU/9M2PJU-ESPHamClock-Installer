# 9M2PJU HamClock (Open HamClock - OHB Edition) — Project Progress & Reference Notes

**Repository:** `https://github.com/9M2PJU/9M2PJU-HamClock-Installer`  
**Maintainer:** 9M2PJU (`9m2pju@hamradio.my` | [HamRadio.my](https://hamradio.my))  
**Backend:** Open HamClock Backend (`ohb.hamclock.app:80`)  
**Version:** `4.29`

---

## 1. Project Overview & Architecture
This project is the definitive open-source installer, multi-platform packaging suite, and web deployment for **HamClock (v4.29)**, configured natively to connect with the **Open HamClock Backend (OHB)** without `/etc/hosts` workarounds.

### Supported Platforms & Targets:
- **1-Line Universal Installer (`install.sh`)**: Linux (Debian, Ubuntu, RPi OS, Arch, Fedora), macOS (Intel/Apple Silicon), and FreeBSD.
- **Android via Termux (`termux/install.sh`)**: Low-power (<3W) touch clock display using Termux + Fully Kiosk Browser.
- **Windows (`scripts/install.ps1`)**: Windows 10/11 with WSLg GUI window or Docker Desktop.
- **Docker Multi-Arch Container (`ghcr.io/9m2pju/9m2pju-hamclock-docker:latest`)**: `linux/amd64`, `linux/arm64`, `linux/arm/v7`.
- **Arch User Repository (`hamclock-git`)**: Native AUR package on `aur.archlinux.org`.
- **Pre-Built Linux Packages**: Multi-arch `.deb`, `.rpm`, `.AppImage` on GitHub Releases.
- **App Store Submissions**:
  - **Flathub**: PR #9797 submitted (`my.hamradio.HamClock`).
  - **Snap Store**: Snapcraft package descriptor (`esphamclock`) configured and published.

---

## 2. Key Accomplishments & Changes Summary

### A. Author & Contact Standardization
- Header comments added across all 14 installation/build/service scripts:
  - `Author: 9M2PJU (https://hamradio.my)`
  - `Contact / Support Email: 9m2pju@hamradio.my`
- Synchronized maintainer contact info in `aur/PKGBUILD`, `snap/snapcraft.yaml`, `packaging/build-deb.sh`, and `packaging/hamclock.spec`.

### B. Docker Container Renaming
- Renamed GitHub Container Registry image to:
  `ghcr.io/9m2pju/9m2pju-hamclock-docker:latest`
- Updated all occurrences across `.github/workflows/docker-publish.yml`, `docker-compose.yml`, `install-docker.sh`, `scripts/install.ps1`, and all markdown documentation.
- Deleted obsolete legacy packages (`9m2pju-esphamclock-installer` and `9m2pju-hamclock-installer`) via GitHub API.

### C. Android & Termux Optimizations
- **Photo Embedded**: Added verified real-world photo (`docs/images/9m2pju-hamclock-android.jpg`) showing HamClock running on Android via Termux + Fully Kiosk Browser.
- **Battery Saver Instructions**: Documented setting Termux battery mode to **"Unrestricted"** and running `termux-wake-lock && hamclock -k &`.
- **Browser Focus**: Standardized documentation exclusively on **Fully Kiosk Browser** as the best auto-fit fullscreen experience for Android.

### D. Package Manager vs 1-Liner Resolution Handling
- **1-Liner**: Interactive resolution menu or environment variable (`TARGET=1600x960`) compiling a single chosen binary.
- **Package Managers (`yay` / AUR, `.deb`, `.rpm`, `Snap`)**:
  - Non-interactive (unattended) build compiling all 6 resolutions (`800x480`, `1600x960`, `2400x1440`, `3200x1920`, `web-800x480`, `web-1600x960`) into `/usr/lib/hamclock/`.
  - Runtime launcher switching via `hamclock -r 1600x960`, `hamclock-1600x960`, or `export HAMCLOCK_RES=1600x960`.
- Documented across `README.md`, `docs/INSTALLATION.md`, and `docs/index.html`.

### E. Packaging & GitHub Actions Enhancements
- Created `packaging/build-in-container.sh` to cleanly build multi-arch binaries inside Docker containers without YAML quoting conflicts.
- Fixed GNU linker library ordering (`LIBS="-lpthread -larduino -lzlib-hc -lws -lX11"`) for Debian Bookworm containers.
- Configured multi-arch Snapcraft builds for `amd64`, `arm64`, and `armhf` on `amd64` runners.

### F. Sponsorship & Funding
- Created `.github/FUNDING.yml`:
  ```yaml
  github: [9M2PJU]
  buy_me_a_coffee: 9m2pju
  custom: ['https://wise.com/pay/me/faizulz13']
  ```
- Added sponsor badges and interactive support sections to `README.md` and GitHub Pages (`docs/index.html`).

### G. GitHub Pages Layout Repairs
- Fixed mobile responsiveness and flex wrapping in install tabs (`.install-tabs`).
- Removed out-of-box floating badges to keep the UI clean and compartmentalized.
- Added dynamic interactive command hints and sponsor anchor navigation.

---

## 3. Important URLs & References
- **Live Website**: [https://hamclock.hamradio.my/](https://hamclock.hamradio.my/)
- **Backend**: [https://ohb.hamclock.app](https://ohb.hamclock.app)
- **GitHub Repo**: [https://github.com/9M2PJU/9M2PJU-HamClock-Installer](https://github.com/9M2PJU/9M2PJU-HamClock-Installer)
- **AUR Package**: [https://aur.archlinux.org/packages/hamclock-git](https://aur.archlinux.org/packages/hamclock-git)
- **Flathub PR**: [https://github.com/flathub/flathub/pull/9797](https://github.com/flathub/flathub/pull/9797)
- **Snapcraft**: [https://snapcraft.io/esphamclock](https://snapcraft.io/esphamclock)
- **Buy Me a Coffee**: [https://buymeacoffee.com/9m2pju](https://buymeacoffee.com/9m2pju)
- **Wise**: [https://wise.com/pay/me/faizulz13](https://wise.com/pay/me/faizulz13)
