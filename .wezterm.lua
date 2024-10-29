-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- config.key_map_preference = "Physical"
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Spacegray Eighties Dull (Gogh)'
config.font = wezterm.font 'Fira Code'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
config.enable_tab_bar = false
config.disable_default_key_bindings = true
config.keys =  {
    {
      key = 'F11',
      action = wezterm.action.ToggleFullScreen,
    },
    -- Copy
    {key="c", mods="CTRL", action=wezterm.action{CopyTo="Clipboard"}},

    -- Paste
    {key="v", mods="CTRL", action=wezterm.action{PasteFrom="Clipboard"}},

    -- new window
    {
      key = 'n',
      mods = 'CTRL',
      action = wezterm.action.SpawnWindow
    },
  }

  config.default_prog = { "/usr/bin/tmux", "new-session", "-A", "-s", "main" }

-- and finally, return the configuration to wezterm
return config
