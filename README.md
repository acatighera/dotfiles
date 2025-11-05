# Omarchy Dotfiles

Laptop-friendly dotfiles that bundle together Hyprland, Waybar, WezTerm, and Neovim with a unified Catppuccin-inspired look. Everything lives under `config/` so it can be stowed or symlinked onto new machines without touching the rest of your `$HOME`.

## Layout

- `config/hypr/hyprland.conf` – compositor + window manager defaults, workspace bindings, launcher integrations.
- `config/waybar/` – Waybar status bar (`config.jsonc` and `style.css`) themed to match Hyprland.
- `config/nvim/` – modular Neovim configuration using `lazy.nvim`.
- `.wezterm.lua` – WezTerm configuration that mirrors the same keybindings and theme.

## Getting Started

1. Clone this repository somewhere convenient, e.g. `~/Projects/dotfiles`.
2. Use GNU Stow (or your favourite symlink manager) to link the configs into place:
   ```bash
   stow --dir ~/Projects/dotfiles/config --target ~/.config hypr waybar nvim
   stow --dir ~/Projects/dotfiles --target ~ .wezterm.lua
   ```
   If you prefer manual links:
   ```bash
   ln -s ~/Projects/dotfiles/config/hypr ~/.config/hypr
   ln -s ~/Projects/dotfiles/config/waybar ~/.config/waybar
   ln -s ~/Projects/dotfiles/config/nvim ~/.config/nvim
   ln -s ~/Projects/dotfiles/.wezterm.lua ~/.wezterm.lua
   ```
3. Start Hyprland and Waybar. WezTerm will pick up the theme automatically, and Neovim will bootstrap `lazy.nvim` on first launch (`:OmarchyInstallLazy` is available if you need to install it manually).

## Notable Defaults

- `SUPER` drives Hyprland: `SUPER+Return` opens WezTerm, `SUPER+D` launches Wofi, workspace numbers live on `SUPER+1…9`.
- Waybar shows workspaces, focused window title, and system stats with icons chosen for laptop use.
- Neovim ships with LSP, completion, Treesitter, Telescope, ToggleTerm, and Git tooling ready to go.
- WezTerm mirrors the Neovim pane navigation keys and uses the Catppuccin Mocha palette.

Feel free to drop host-specific overrides alongside the base configs (e.g. `config/hypr/monitors.conf`) and `source=` them from `hyprland.conf` when you need per-machine tweaks.
