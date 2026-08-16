# 🪟 Windows Installation & User Guide

**9M2PJU ESPHamClock (Open HamClock - OHB Edition)** can be run effortlessly on Windows 10 and Windows 11 using several convenient options.

---

## ⚡ Method 1: 1-Click Automated PowerShell Installer (Fastest)

Open **PowerShell** (press `Win + X`, then click **Terminal** or **PowerShell**) and paste:

```powershell
irm https://raw.githubusercontent.com/9M2PJU/9M2PJU-ESPHamClock-Installer/main/scripts/install.ps1 | iex
```

The script automatically checks your environment (Docker Desktop or WSL2), sets up HamClock, and opens the live dashboard in your browser.

---

## 🐧 Method 2: Native Windows Desktop App via WSL2 / WSLg (Recommended for GUI)

On modern Windows 10 (Build 19044+) and Windows 11, **WSLg** provides seamless native graphical window rendering on your Windows desktop.

### 1. Enable WSL (If not already installed)
In PowerShell as Administrator:
```powershell
wsl --install
```

### 2. Install HamClock in WSL
Open **Ubuntu** or your WSL terminal and run:
```bash
curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-ESPHamClock-Installer/main/install.sh | bash
```

### 3. Launch from Windows
You can launch HamClock directly from Windows PowerShell or the Run dialog (`Win + R`):
```powershell
wsl -e ~/.local/bin/hamclock -r 1600x960
```
A floating native window appears seamlessly on your Windows desktop with high-DPI scaling and hardware acceleration.

---

## 🐳 Method 3: Docker Desktop for Windows

If you use **Docker Desktop**, run the container with persistent configuration:

```powershell
docker run -d `
  --name hamclock `
  --restart unless-stopped `
  -p 8080:8080 `
  -p 8081:8081 `
  -p 8082:8082 `
  -v "$env:USERPROFILE\.hamclock:/root/.hamclock" `
  ghcr.io/9m2pju/9m2pju-esphamclock-installer:latest
```

### Accessing the Web Dashboard:
- **Interactive Live Mirror (Read/Write)**: Open Microsoft Edge or Chrome and navigate to:
  ```
  http://localhost:8081/live.html
  ```
- **Read-Only Monitor**: `http://localhost:8082/live.html`
- **RESTful Snapshot PNG**: `http://localhost:8080/live.png`

---

## 🚀 Starting HamClock Automatically on Windows Boot

### For Docker Desktop:
Docker Desktop automatically restarts the container on boot when `--restart unless-stopped` is specified.

### For WSL2 Background Service:
Create a shortcut in your Windows Startup folder (`Win + R` $\to$ `shell:startup`):
- **Target**: `wsl.exe -d Ubuntu -e ~/.local/bin/hamclock -r 1600x960`
