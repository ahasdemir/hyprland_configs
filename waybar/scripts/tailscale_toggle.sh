#!/bin/sh

if ! command -v tailscale >/dev/null 2>&1; then
    notify-send -u critical "Tailscale" "Tailscale CLI is not installed"
    exit 1
fi

status=$(tailscale status --json 2>/dev/null | jq -r '.BackendState // "Stopped"')

if [ "$status" = "Running" ]; then
    tailscale down
    notify-send -u low "Tailscale" "Disconnected from Tailscale VPN"
else
    tailscale up
    notify-send -u low "Tailscale" "Connected to Tailscale VPN"
fi
