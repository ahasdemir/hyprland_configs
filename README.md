# 🌌 Hyprland & Omarchy Desktop Configurations

Personal dotfiles and custom configurations for Hyprland, Waybar, Zsh, Walker, Mako, and terminal emulators on Omarchy / CachyOS Linux.

## 📁 Repository Structure

```
~/projects/hyprland_configs/
├── hypr/                 # Hyprland WM configuration (monitors, keybindings, input, look & feel)
├── waybar/               # Custom modular Waybar layout, scripts & styles
├── zsh/                  # Zsh shell configuration & Powerlevel10k theme
├── walker/               # Walker application launcher configuration
├── mako/                 # Notification daemon settings
├── kitty/                # Kitty terminal configuration
├── ghostty/              # Ghostty terminal configuration
└── alacritty/            # Alacritty terminal configuration
```

## 🛠️ Key Highlights

* **Modular Waybar**: Separated `modules.json` and `config.jsonc` layout.
* **Interactive Modules**:
  * 🔒 **Tailscale VPN**: Interactive toggle icon with real-time status notifications.
  * 🎙️ **Microphone & Speaker**: Symmetrical audio modules with left-click mute toggling & SwayOSD feedback.
  * ⌨️ **Dual Keyboard Layouts**: `Turkish` (TR) and `English` (US) toggled via **`Alt` + `Space`**.
  * 🌐 **Network Status**: Live Ethernet interface notifications & IP display.
  * 🌤️ **Nerd Font Weather**: Custom live weather script with temperature display.
* **Pixel-Perfect Spacing**: Balanced vertical margins and symmetrical horizontal icon gaps.

## 🚀 Symlink Setup Script

To link all configuration directories from this repository into `~/.config/`:

```bash
mkdir -p ~/.config

for dir in hypr waybar zsh walker mako kitty ghostty alacritty; do
    rm -rf "$HOME/.config/$dir"
    ln -s "$HOME/projects/hyprland_configs/$dir" "$HOME/.config/$dir"
done

# Reload environment
hyprctl reload
omarchy restart waybar
```
