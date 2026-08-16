#!/bin/bash
# ==============================================================================
# HamClock Background Service Helper for Android Termux
# Starts HamClock with wake-lock to prevent CPU sleep
# ==============================================================================

if command -v termux-wake-lock >/dev/null 2>&1; then
    echo "Acquiring Termux wake lock..."
    termux-wake-lock
fi

echo "Starting HamClock Web Server on :8080..."
exec hamclock
