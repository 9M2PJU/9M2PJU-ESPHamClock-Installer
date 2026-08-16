# 📦 Flatpak & Flathub Submission Guide

This directory contains the official Flathub Flatpak packaging files for **9M2PJU HamClock (Open HamClock - OHB Edition)**.

- **Application ID**: `my.hamradio.HamClock`
- **Domain**: `hamradio.my`

---

## 📂 Files Overview

| File | Purpose |
| :--- | :--- |
| [`my.hamradio.HamClock.yml`](my.hamradio.HamClock.yml) | Main Flathub build manifest |
| [`my.hamradio.HamClock.metainfo.xml`](my.hamradio.HamClock.metainfo.xml) | AppStream store metadata & screenshot |
| [`my.hamradio.HamClock.desktop`](my.hamradio.HamClock.desktop) | FreeDesktop application launcher |
| [`my.hamradio.HamClock.png`](my.hamradio.HamClock.png) | 128x128 application icon |

---

## 🚀 How to Submit to Flathub

According to official [Flathub App Submission Guidelines](https://docs.flathub.org/docs/for-app-authors/submission):

### Step 1: Fork the Flathub Repository
1. Go to [https://github.com/flathub/flathub](https://github.com/flathub/flathub).
2. Click **Fork** to create a copy under your GitHub account (`9M2PJU/flathub`).

### Step 2: Clone and Create Branch
```bash
git clone git@github.com:9M2PJU/flathub.git /tmp/flathub-submission
cd /tmp/flathub-submission
git checkout -b new-pr/my.hamradio.HamClock
```

### Step 3: Copy the Manifest
```bash
cp ./flatpak/my.hamradio.HamClock.yml .
git add my.hamradio.HamClock.yml
git commit -m "Add my.hamradio.HamClock (9M2PJU HamClock)"
git push -u origin new-pr/my.hamradio.HamClock
```

### Step 4: Open Pull Request
1. Go to [https://github.com/flathub/flathub/pulls](https://github.com/flathub/flathub/pulls).
2. Click **New pull request**.
3. Select `flathub:master` $\leftarrow$ `9M2PJU:new-pr/my.hamradio.HamClock`.
4. Flathub's automated buildbot (`@flathubbot`) will trigger a test build for `x86_64` and `aarch64`.
5. Once approved by the Flathub team, the repository `https://github.com/flathub/my.hamradio.HamClock` will be generated and published to Flathub automatically!

---

## 💻 Local Testing with Flatpak Builder

```bash
# Install Freedesktop SDK & Platform runtime
flatpak install flathub org.freedesktop.Platform//24.08 org.freedesktop.Sdk//24.08

# Build locally
flatpak-builder --user --install --force-clean build-dir flatpak/my.hamradio.HamClock.yml

# Run locally
flatpak run my.hamradio.HamClock
```
