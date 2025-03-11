-- Pull in the wezterm API
local wezterm = require 'wezterm'

local function is_vim(pane)
  -- this is set by the plugin, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

-- This will hold the configuration.
local config = wezterm.config_builder()

-- For example, changing the color scheme:
config.color_scheme = 'Spacegray Eighties Dull (Gogh)'
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 14.0
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
config.enable_tab_bar = false
config.disable_default_key_bindings = true
-- config.window_decorations = "NONE"
config.keys =  {
    {
      key = 'F11',
      action = wezterm.action.ToggleFullScreen,
    },
    -- Copy
     {key="c", mods="CMD", action=wezterm.action{CopyTo="Clipboard"}},

    -- Paste
    {key="v", mods="CMD", action=wezterm.action{PasteFrom="Clipboard"}},

    -- new window
    {
      key = 'n',
      mods = 'CTRL',
      action = wezterm.action.SpawnWindow
    },
    -- move between split panes
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
    -- resize panes
    split_nav('resize', 'h'),
    split_nav('resize', 'j'),
    split_nav('resize', 'k'),
    split_nav('resize', 'l'),
}

-- config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "main" }

-- and finally, return the configuration to wezterm
return config
