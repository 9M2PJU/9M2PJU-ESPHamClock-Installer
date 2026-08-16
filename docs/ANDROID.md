# 📱 Android & Termux Installation Guide

**9M2PJU HamClock (Open HamClock - OHB Edition)** can run natively on any **Android phone, tablet, or TV box** using [Termux](https://termux.dev/). 

Repurposing an old or spare Android tablet makes one of the **cheapest, lowest-power (<3W), and most responsive dedicated HamClock touch dashboards** for your amateur radio shack!

---

## ⚡ 1-Liner Quick Install (Termux)

Open the **Termux** app and paste this single command:

```bash
pkg update -y && pkg install -y curl && bash -c "$(curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/termux/install.sh)"
```

---

## 📖 Step-by-Step Setup Walkthrough

### Step 1: Install Termux
> ⚠️ **Important:** Do **NOT** install Termux from Google Play Store (it is deprecated and unmaintained). Install the latest release from:
- [**F-Droid (Recommended)**](https://f-droid.org/en/packages/com.termux/)
- [**GitHub Releases**](https://github.com/termux/termux-app/releases)

---

### Step 2: Run the Installer
Open Termux and run the installer one-liner:
```bash
pkg update -y && pkg install -y curl && bash -c "$(curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/termux/install.sh)"
```
The script will automatically:
1. Detect Termux on Android.
2. Install `clang`, `make`, `git`, and `curl` via `pkg`.
3. Prompt you for your desired resolution (default: `1600x960` for tablets, or `800x480` for phones).
4. Apply Android Bionic `fdsan` protection.
5. Compile the optimized native ARM binary and install `hamclock` to `$PREFIX/bin/hamclock`.

---

### Step 3: Launch HamClock in Background
```bash
hamclock -k &
```
*(The `-k` flag skips the setup countdown and boots immediately).*

---

### Step 4: Open in Your Android Browser
1. Open **Google Chrome**, **Brave**, or **Firefox** on your Android device.
2. Navigate to:
   ```text
   http://localhost:8081/live.html
   ```
3. You now have a full, high-speed, touch-interactive HamClock mirror running locally on your device!

---

### Step 5: Make It Full-Screen & Fit to Screen

There are three ways to get a borderless, full-screen display on Android:

#### Option A: Add to Home Screen (PWA Mode — Easiest & Recommended)
1. In Chrome, Brave, or Firefox, tap the **three-dot menu (`⋮`)** in the upper right.
2. Tap **"Add to Home screen"** (or **"Install app"**).
3. Name it **HamClock** and tap **Add**.
4. Launch HamClock from your Android Home Screen — it will run as a standalone, borderless full-screen application with no browser URL bar!

#### Option B: Enable "Web Full Screen" in HamClock Setup
1. Tap the **Callsign / Lock** area on the HamClock screen to enter **Setup**.
2. Set **`Web full scrn`** to **`Yes`** and tap **Done**.
3. Next time you tap anywhere on the screen, the browser will expand to HTML5 full-screen.

#### Option C: Fully Kiosk Browser (Best for Permanent Wall/Desk Clocks)
For a 24/7 dedicated shack clock tablet, install [**Fully Kiosk Browser**](https://play.google.com/store/apps/details?id=de.fullyfactory.fully):
- Set Start URL to `http://localhost:8081/live.html`.
- Enable **Fullscreen Mode** (hides Android navigation bar & status bar).
- Enable **Keep Screen On** and **Auto-scale content to fit window**.

---

## 🎯 Direct Non-Interactive Resolution Install

You can bypass the interactive menu by setting `TARGET`:

```bash
# For Tablets & 1080p Screens (Default)
TARGET=1600x960 bash -c "$(curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/termux/install.sh)"

# For Phones & Compact Screens
TARGET=800x480 bash -c "$(curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/termux/install.sh)"

# For 2K High-DPI Tablets
TARGET=2400x1440 bash -c "$(curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/termux/install.sh)"
```

---

## 🔋 24/7 Shack Dashboard Optimizations

If you are using your Android device as a permanent wall-mounted or desk-mounted HamClock:

### 1. Prevent Android from Sleeping (Wake Lock)
Keep the Termux background service alive even when switching apps or locking the screen:
```bash
termux-wake-lock
```
Also, go to Android **Settings $\to$ Apps $\to$ Termux $\to$ Battery** and set it to **"Unrestricted"** (disable battery optimization).

### 2. Dedicated Kiosk Mode (Wall Clocks)
For a permanent shack wall clock, use [**Fully Kiosk Browser**](https://www.fully-kiosk.com/) (free on Android) or Android's built-in **App Pinning / Screen Pinning**:
- Auto-starts on tablet boot.
- Locks the screen to `http://localhost:8081/live.html`.
- Keeps the screen always on with adjustable brightness schedules.

---

## 🔄 Autostart on Android Boot (Termux:Boot)

To have HamClock automatically start in the background whenever your Android device reboots:

1. Install the [**Termux:Boot**](https://f-droid.org/en/packages/com.termux.boot/) add-on from F-Droid.
2. Open the Termux:Boot app once to register permissions.
3. Inside Termux, create a boot script:
   ```bash
   mkdir -p ~/.termux/boot
   cat << 'EOF' > ~/.termux/boot/start-hamclock.sh
   #!/data/data/com.termux/files/usr/bin/bash
   termux-wake-lock
   hamclock -k &
   EOF
   chmod +x ~/.termux/boot/start-hamclock.sh
   ```

---

## 🖥️ Advanced: Native X11 Window (via Termux:X11)

If you prefer running HamClock as an X11 window rather than through the web server:

1. Install the companion [**Termux:X11**](https://github.com/termux/termux-x11/releases) app.
2. Inside Termux, install X11 packages:
   ```bash
   pkg install -y x11-repo
   pkg install -y clang make libx11 git
   ```
3. Compile the X11 target:
   ```bash
   ./termux/build.sh hamclock-1600x960
   cp hamclock-1600x960 $PREFIX/bin/hamclock
   ```
4. Start the Termux:X11 server and run:
   ```bash
   export DISPLAY=:0
   hamclock
   ```

---

## 🐧 Advanced: Running via PRoot Linux (Debian / Ubuntu)

If you prefer a standard full Linux distribution inside Termux:

```bash
pkg install -y proot-distro
proot-distro install debian
proot-distro login debian
curl -fsSL https://raw.githubusercontent.com/9M2PJU/9M2PJU-HamClock-Installer/main/install.sh | bash
```

---

<div align="center">

```
73 de 9M2PJU • Enjoy HamClock on Android!
```

</div>
