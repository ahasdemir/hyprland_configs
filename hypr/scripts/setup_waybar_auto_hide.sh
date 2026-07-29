#!/usr/bin/env bash
# Script to download, build, and link waybar_auto_hide from https://github.com/Zephirus2/waybar_auto_hide

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_BIN="$SCRIPT_DIR/waybar_auto_hide"
REPO_URL="https://github.com/Zephirus2/waybar_auto_hide.git"

echo "=== Waybar Auto Hide Setup ==="

if command -v cargo &> /dev/null; then
    echo "Rust/Cargo detected. Cloning and building latest waybar_auto_hide from source..."
    TMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TMP_DIR"' EXIT

    git clone "$REPO_URL" "$TMP_DIR/waybar_auto_hide"
    cd "$TMP_DIR/waybar_auto_hide"
    cargo build --release

    install -m 755 "$TMP_DIR/waybar_auto_hide/target/release/waybar_auto_hide" "$TARGET_BIN"
    echo "✓ Successfully built and updated binary at $TARGET_BIN"
else
    echo "Cargo is not installed. Checking for existing binary..."
    if [ -f "$TARGET_BIN" ]; then
        chmod +x "$TARGET_BIN"
        echo "✓ Existing binary found at $TARGET_BIN"
    else
        echo "✗ Error: Cargo is required to build waybar_auto_hide from source."
        echo "Please install Rust (https://rustup.rs) or cargo via pacman."
        exit 1
    fi
fi

# Ensure autostart entry exists
AUTOSTART_CONF="$(dirname "$SCRIPT_DIR")/autostart.conf"
if [ -f "$AUTOSTART_CONF" ]; then
    if ! grep -q "waybar_auto_hide" "$AUTOSTART_CONF"; then
        echo 'exec-once = $HOME/.config/hypr/scripts/waybar_auto_hide &' >> "$AUTOSTART_CONF"
        echo "✓ Added waybar_auto_hide entry to autostart.conf"
    else
        echo "✓ waybar_auto_hide is already configured in autostart.conf"
    fi
fi

echo "=== Setup Complete ==="
