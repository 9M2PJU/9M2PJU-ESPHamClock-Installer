# ⚙️ HamClock Configuration & Settings Guide

HamClock provides a rich graphical setup interface stored in `~/.hamclock/hamclock.nvram` (or specified via `-d`).

---

## 🛠️ Accessing Setup

You can access the Setup screens through any of these methods:
1. **Padlock Icon**: Click or touch the small lock icon on the main clock interface.
2. **Key / Shortcut**: Press `Spacebar` while focused on the clock window.
3. **First Launch**: Run `hamclock` without `-k` to enter initial countdown setup.

---

## 📄 Setup Pages Overview

### Page 1: Station Identification & Geographic Coordinates
- **Call sign**: Your amateur radio callsign (displayed on the main clock banner).
- **DE Lat / Long / Grid**: Your transmitter station location (e.g. `3.1390 N, 101.6869 E` or Maidenhead grid `OJ03ue`).
  - *Tip:* Use `-g` CLI option on launch for automatic IP-based geolocation initialization.
- **DX Lat / Long / Grid**: Target / partner station coordinates for great-circle path calculations, bearing, and distance.
- **Time Offsets**: Configure UTC vs. local timezone offsets and display formats.
- **GPS / NTP Time Sync**: Set preferred time sources.

---

### Page 2: Peripherals, Rig & Rotator Control
- **`Radio?`**:
  - `rigctld`: Enable Hamlib radio control (Default Port: `4532`).
  - `flrig`: Enable FLDIGI suite radio control (Default Port: `12345`).
- **`rotctld?`**: Enable Hamlib rotator azimuth/elevation control (Default Port: `4533`).
- **`BME280?` / Sensors**: Enable local ambient environmental telemetry (temperature, barometric pressure, humidity) via I2C sensors.
- **GPIO Pins / Relays**: Configure Raspberry Pi GPIO triggers for external hardware switching.

---

### Page 3: Display, Map Layers & Panes
- **Map Projections**:
  - `Mercator`: Classic cylindrical projection.
  - `Azimuthal`: Polar / great-circle projection centered directly on your home station (DE).
  - `Robinson / Mollweide`: Equal-area global maps.
- **Day / Night Terminator**: Select line style and night-side shading style.
- **Auroral Oval & Solar Terminator**: Enable real-time NOAA solar terminator and visual aurora oval predictions.
- **Borders & Grid Lines**: Toggle political boundaries, Maidenhead grid squares, and CQ/ITU zones.

---

### Page 4: Data Sources & Cluster Integration
- **Backend Host**: Hardcoded to `ohb.hamclock.app:80` (Open HamClock Backend).
- **DX Cluster**:
  - Server hostname (e.g. `dxc.nc7j.com` or your local cluster node).
  - Port (default: `7300`).
  - Callsign and login credentials for auto-filtering.
- **ADIF Live Log Feed**:
  - UDP port for receiving broadcast QSOs from WSJT-X, N1MM Logger+, or Log4OM (default: `2237`).
- **Space Weather & Solar Images**:
  - Choose between SDO (Solar Dynamics Observatory) wavelength imagery (e.g. AIA 193Å, 304Å, 171Å) or magnetograms.

---

## 💾 Configuration Backup & Restore

HamClock preserves all user configuration in a single directory:
- Default location: `~/.hamclock/`
- Configuration file: `~/.hamclock/hamclock.nvram`

To backup or migrate your HamClock configuration:
```bash
# Backup
cp ~/.hamclock/hamclock.nvram ~/hamclock_backup.nvram

# Restore
cp ~/hamclock_backup.nvram ~/.hamclock/hamclock.nvram
```
