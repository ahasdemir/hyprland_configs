#!/usr/bin/env bash

action="$1" # "copy", "paste", "cut"

active_class=$(hyprctl activewindow -j | jq -r '.class // empty')

is_terminal=false
case "$active_class" in
    com.mitchellh.ghostty|ghostty|Alacritty|alacritty|kitty|foot|org.wezfurlong.wezterm|rio)
        is_terminal=true
        ;;
esac

if [ "$is_terminal" = true ]; then
    case "$action" in
        copy)
            hyprctl dispatch sendshortcut "CTRL SHIFT, C, activewindow"
            ;;
        paste)
            hyprctl dispatch sendshortcut "CTRL SHIFT, V, activewindow"
            ;;
        cut)
            hyprctl dispatch sendshortcut "CTRL SHIFT, X, activewindow"
            ;;
    esac
else
    case "$action" in
        copy)
            hyprctl dispatch sendshortcut "CTRL, C, activewindow"
            ;;
        paste)
            hyprctl dispatch sendshortcut "CTRL, V, activewindow"
            ;;
        cut)
            hyprctl dispatch sendshortcut "CTRL, X, activewindow"
            ;;
    esac
fi
