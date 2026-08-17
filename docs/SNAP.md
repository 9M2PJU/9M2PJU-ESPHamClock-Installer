# 📦 Canonical Snap Package Guide

**9M2PJU HamClock (Open HamClock - OHB Edition)** can be published and installed directly from Canonical's **Snap Store** across Ubuntu, Debian, Fedora, Arch Linux, openSUSE, and Manjaro.

---

## ⚡ User Installation

The snap is currently published on the `candidate` channel pending Canonical's stable review:

```bash
# Install from the candidate channel (stable review pending)
sudo snap install esphamclock --candidate

# Launch HamClock
esphamclock

# Launch with specific resolution
esphamclock -r 1600x960
```

Once Canonical approves the stable release, the install command simplifies to `sudo snap install esphamclock`.

---

## 🛠️ Maintainer Guide: Registering & Publishing to Snap Store

To publish `esphamclock` under your Canonical developer account (**9M2PJU**):

### 1. Register the Name on Snapcraft
Visit [snapcraft.io/register-snap](https://snapcraft.io/register-snap) or run:
```bash
snapcraft login
snapcraft register esphamclock
```

### 2. Generate Store Credentials for GitHub Actions
Export a secure deployment token:
```bash
snapcraft export-login --snaps=esphamclock --channels=edge,beta,candidate,stable snapcraft.token
```

### 3. Add to GitHub Secrets
1. Go to your repository: **Settings $\to$ Secrets and variables $\to$ Actions**.
2. Click **New repository secret**.
3. Name: `SNAPCRAFT_STORE_CREDENTIALS`
4. Value: Paste the contents of `snapcraft.token`.

Every new release tag (e.g. `v4.29`) pushed to GitHub will automatically compile multi-architecture snaps (`amd64`, `arm64`, `armhf`) and release them to the Snap Store!
