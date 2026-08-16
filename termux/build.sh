#!/bin/bash
# ==============================================================================
# HamClock Standalone Build Helper for Android Termux
# Builds HamClock without modifying upstream source files.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

TARGET="${1:-hamclock-web-1600x960}"
NPROCS=$(nproc 2>/dev/null || echo 2)

echo "==> Building $TARGET for Android Termux using Clang ($NPROCS cores)..."
make "$TARGET" CXX="clang++" -j"$NPROCS"

echo "==> Build successful: $SCRIPT_DIR/$TARGET"
