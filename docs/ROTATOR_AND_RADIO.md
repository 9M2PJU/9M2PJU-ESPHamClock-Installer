# 📻 HamClock Rotator & Radio (CAT) Control Guide

HamClock includes built-in hardware control for **Antenna Rotators** and **Transceivers / Radios**, architected by the original author, **Elwood Downey (WB0OEW)**—leveraging his extensive background in astronomy, telescope mounts, and celestial tracking (*XEphem*).

Because HamClock connects via TCP/IP sockets over your local network, your rotator and radio can be connected to the same machine running HamClock or any other computer/Raspberry Pi in your ham shack.

---

## 🧭 Part 1: Antenna Rotator Control

HamClock communicates with antenna rotators using Hamlib’s **`rotctld`** daemon. It supports:
- **1-Axis Rotators (Azimuth)**: For directional HF/VHF/UHF beam antennas (Yagi, Hexbeam, Moxon, Quad).
- **2-Axis Rotators (Azimuth + Elevation)**: For satellite and EME tracking antenna arrays.

### 1. Launch `rotctld` on your Radio/Controller PC

Identify your rotator model ID in Hamlib by running `rotctl -l`.

#### Common Rotator Examples:
```bash
# Yaesu GS-232A / GS-232B (Model 601) on USB Serial /dev/ttyUSB0:
rotctld -m 601 -r /dev/ttyUSB0 -s 9600 -T 0.0.0.0 -t 4533

# Easy-Comm II / Arduino Rotator Controller (Model 202):
rotctld -m 202 -r /dev/ttyACM0 -s 9600 -T 0.0.0.0 -t 4533

# AlfaSpid RAK / BIG-RAK (Model 901):
rotctld -m 901 -r /dev/ttyUSB0 -s 1200 -T 0.0.0.0 -t 4533
```
> **Note:** The `-T 0.0.0.0` parameter instructs `rotctld` to accept incoming socket connections from any IP on your local network (LAN).

---

### 2. Configure HamClock

1. Open HamClock **Setup** (tap/click the setup padlock icon or restart without `-k`).
2. Navigate to **Page 2 (Rig / Rotator / Peripherals)**.
3. Configure the following fields:
   - **`rotctld?`**: Set to `Yes`.
   - **`Host`**: IP address or hostname of the machine running `rotctld` (e.g. `127.0.0.1` or `192.168.1.50`).
   - **`Port`**: Port number for `rotctld` (default: `4533`).
4. Save and return to the main display.

---

### 3. Rotator In-Action Features

- **Gimbal Pane**: Click any of the 4 customizable pane boxes and select **Gimbal**. HamClock displays real-time Azimuth (and Elevation) dials.
- **Auto-Turn to DX (Map Integration)**: Click the **`Auto`** button on the Gimbal pane. Whenever you click anywhere on the world map or enter a DX callsign/grid, HamClock immediately commands the rotator to point to the Short Path (SP) or Long Path (LP) bearing!
- **Real-Time Satellite Tracking**: When tracking an active satellite pass in HamClock (e.g. ISS, AO-91, RS-44, IO-117), HamClock automatically moves the rotator in real-time across both Azimuth and Elevation as the pass progresses!
- **Manual Nudge**: Tap the left/right arrow buttons on the Gimbal pane to manually step azimuth by 5° or 20°.

---

## 📻 Part 2: Radio / Transceiver CAT Control

HamClock connects to your transceiver via **`rigctld` (Hamlib)** or **`flrig` (FLDIGI Suite)**.

### 1. Launch `rigctld` or `flrig`

#### Option A: Using Hamlib `rigctld`
Identify your transceiver model in Hamlib (`rigctl -l`):

```bash
# ICOM IC-7300 (Model 3073) on /dev/ttyUSB0 at 115200 baud:
rigctld -m 3073 -r /dev/ttyUSB0 -s 115200 -T 0.0.0.0 -t 4532

# Yaesu FT-710 / FT-991A (Model 1045 / 1035):
rigctld -m 1045 -r /dev/ttyUSB0 -s 38400 -T 0.0.0.0 -t 4532

# Elecraft K3 / KX3 (Model 2029 / 2030):
rigctld -m 2030 -r /dev/ttyUSB0 -s 38400 -T 0.0.0.0 -t 4532
```

#### Option B: Using FLRig
1. Open the **FLRig** graphical application.
2. Go to **Config -> Setup -> Transceiver** and select your radio, serial port, and baud rate.
3. In **Config -> Setup -> Server**, make sure the XML-RPC server is enabled on port `12345`.

---

### 2. Configure HamClock

1. In HamClock **Setup** (Page 2), locate the **`Radio?`** section.
2. Select **`rigctld`** or **`flrig`**.
3. Set **`Host`**: IP address running `rigctld` or `flrig` (e.g., `127.0.0.1` or `192.168.1.50`).
4. Set **`Port`**: `4532` for `rigctld` or `12345` for `flrig`.
5. Save settings.

---

### 3. Radio In-Action Features

- **Dynamic VOACAP Band Switching**: As you spin your physical radio's VFO dial (e.g., changing bands from 20m to 15m or 10m), HamClock detects the frequency and dynamically updates the on-screen VOACAP propagation map to reflect the active band!
- **Click-to-Tune (QSY from DX Spots & Clusters)**: When DX Cluster, POTA, SOTA, or PSK spots appear in HamClock panes, clicking on a spot opens a QSY confirmation dialog. Clicking OK instantly sends CAT commands to tune your radio to the spotted frequency!
- **Live On-Air PTT Indicator**: Whenever you key the transmitter, HamClock highlights the **ON AIR** badge in red on the main clock interface.

---

## 🌐 Remote REST & Web API Reference

You can also automate rotator and radio commands from external scripts or home automation tools:

| Endpoint | Method | Example | Description |
| :--- | :--- | :--- | :--- |
| `/get_rotator` | `GET` | `http://hamclock:8080/get_rotator` | Returns current Azimuth, Elevation, and moving state. |
| `/set_rotator` | `GET` | `http://hamclock:8080/set_rotator?az=145&el=30` | Moves rotator to specified Azimuth and Elevation. |
| `/set_rotator` | `GET` | `http://hamclock:8080/set_rotator?state=stop` | Immediately halts rotator movement. |
| `/get_radio` | `GET` | `http://hamclock:8080/get_radio` | Returns active frequency, mode, and PTT state. |
| `/set_radio` | `GET` | `http://hamclock:8080/set_radio?freq=14074000&mode=USB` | Tunes transceiver to specified frequency and mode. |
