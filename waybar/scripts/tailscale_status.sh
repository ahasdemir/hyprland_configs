#!/bin/sh

if ! command -v tailscale >/dev/null 2>&1; then
    printf '{"text": "", "class": "none", "tooltip": "Tailscale not installed"}\n'
    exit 0
fi

tailscale_output="$(tailscale status --json 2>/dev/null)"
if [ -z "$tailscale_output" ]; then
    printf '{"text": "󰖆", "class": "down", "tooltip": "Tailscale: Disconnected (Click to connect)"}\n'
    exit 0
fi

active=$(echo "$tailscale_output" | jq -r '.Self.Online // false')
status=$(echo "$tailscale_output" | jq -r '.BackendState // "Stopped"')

if [ "$status" = "Running" ] && [ "$active" = "true" ]; then
    TEXT="󰖂"
    CLASS="up"
    TOOLTIP="Tailscale: Connected (Click to disconnect)"
else
    TEXT="󰖆"
    CLASS="down"
    TOOLTIP="Tailscale: Disconnected (Click to connect)"
fi

printf '{"text": "%s", "class": "%s", "tooltip": "%s"}\n' "$TEXT" "$CLASS" "$TOOLTIP"
