# Hyprland & Omarchy Desktop Configurations

Personal dotfiles and custom configurations for Hyprland, Waybar, SwayOSD, Zsh, Walker, Mako, and terminal emulators on Omarchy / CachyOS Linux.

## Repository Structure

```
~/hyprland_configs/
├── hypr/                 # Hyprland WM configuration (monitors, keybindings, input, look & feel)
│   ├── autostart.conf    # Process autostart (Waybar auto-hide, rclone, etc.)
│   └── scripts/          # Helper scripts & submodules
│       ├── setup_waybar_auto_hide.sh  # Script to clone, build & link waybar_auto_hide
│       ├── waybar_auto_hide          # Compiled binary executable for Waybar auto-hiding
│       ├── clipboard-action.sh
│       └── hypr-ai-grammar/
├── waybar/               # Custom modular Waybar layout, scripts & styles
├── swayosd/              # SwayOSD volume, brightness & mic mute popups configuration
├── zsh/                  # Zsh shell configuration & Powerlevel10k theme
├── walker/               # Walker application launcher configuration
├── mako/                 # Notification daemon settings
├── kitty/                # Kitty terminal configuration
├── ghostty/              # Ghostty terminal configuration
└── alacritty/            # Alacritty terminal configuration
```

## Key Highlights

* **Waybar Auto Hide Integration**: Automatically hides/unhides Waybar based on window focus & mouse pointer location powered by [waybar_auto_hide](https://github.com/Zephirus2/waybar_auto_hide).
* **Modular Waybar**: Separated `modules.json` and `config.jsonc` layout.
* **Interactive Modules**:
  * **Tailscale VPN**: Interactive toggle icon with real-time status notifications.
  * **Microphone & Speaker**: Symmetrical audio modules with left-click mute toggling & SwayOSD feedback.
  * **Dual Keyboard Layouts**: Turkish (TR) and English (US) toggled via Left Alt + Right Alt.
  * **Network Status**: Live Ethernet interface notifications & IP display.
  * **Nerd Font Weather**: Custom live weather script with temperature display.
* **Pixel-Perfect Spacing**: Balanced vertical margins and symmetrical horizontal icon gaps.
* **SwayOSD Styling**: Customized On-Screen Display popups for volume, brightness, and mic mute.

## Waybar Auto Hide Setup & Linking

This setup includes [Zephirus2/waybar_auto_hide](https://github.com/Zephirus2/waybar_auto_hide), a Rust utility that dynamically toggles Waybar visibility in Hyprland.

It is automatically executed on login via `hypr/autostart.conf`:
```ini
exec-once = $HOME/.config/hypr/scripts/waybar_auto_hide &
```

### Methods to Link & Build `waybar_auto_hide`

#### Method 1: Automatic Linking via Setup Helper (Recommended)
Run the included helper script to clone the source repo, build the release binary using Cargo, link it inside `hypr/scripts/`, and verify the autostart entry:
```bash
./hypr/scripts/setup_waybar_auto_hide.sh
```

#### Method 2: Manual Build & Link from Source
If you prefer to clone and build [Zephirus2/waybar_auto_hide](https://github.com/Zephirus2/waybar_auto_hide) manually:
```bash
# Clone and build
git clone https://github.com/Zephirus2/waybar_auto_hide.git /tmp/waybar_auto_hide
cd /tmp/waybar_auto_hide
cargo build --release

# Copy binary safely to hypr/scripts/
install -m 755 target/release/waybar_auto_hide ~/hyprland_configs/hypr/scripts/waybar_auto_hide
rm -rf /tmp/waybar_auto_hide
```

#### Method 3: Global Cargo Install & Symlink
You can also install `waybar_auto_hide` globally into `~/.cargo/bin/` and symlink it:
```bash
cargo install --git https://github.com/Zephirus2/waybar_auto_hide
ln -sf ~/.cargo/bin/waybar_auto_hide ~/hyprland_configs/hypr/scripts/waybar_auto_hide
```

## Symlink Setup Script

To link all configuration directories from this repository into `~/.config/`:

```bash
mkdir -p ~/.config

for dir in hypr waybar swayosd zsh walker mako kitty ghostty alacritty; do
    rm -rf "$HOME/.config/$dir"
    ln -s "$HOME/hyprland_configs/$dir" "$HOME/.config/$dir"
done

# Reload environment
hyprctl reload
omarchy restart waybar
```
