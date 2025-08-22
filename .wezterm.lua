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
config.window_decorations = "TITLE|RESIZE"
config.keys =  {
    {
      key = 'F11',
      action = wezterm.action.ToggleFullScreen,
    },
    -- GUI‑style copy / paste

    {
    key = 'c',
    mods = 'CTRL',
    action = wezterm.action_callback(function(window, pane)
        selection_text = window:get_selection_text_for_pane(pane)
        is_selection_active = string.len(selection_text) ~= 0
        if is_selection_active then
            window:perform_action(wezterm.action.CopyTo('ClipboardAndPrimarySelection'), pane)
        else
            window:perform_action(wezterm.action.SendKey{ key='c', mods='CTRL' }, pane)
        end
    end),
    },
{
  key  = 'v',
  mods = 'CTRL',
  action = wezterm.action_callback(function(window, pane)
    -- What program is currently running in this pane?
    local proc = pane:get_foreground_process_name() or ''

    -- `ssh … vim` shows up as just "ssh", so catch that too by
    -- looking at the title Vim sets when it starts.
    local title = pane:get_title()

    local inside_vim =
      proc:match('vim')   or   -- local vim/nvim
      title:match('vim')  or   -- remote-vim window title
      title:match('NVIM')      -- neovim’s default title

    if inside_vim then
      -- Let Vim receive the real <C‑v> (block‑visual mode, etc.)
      window:perform_action(
        wezterm.action.SendKey{ key = 'v', mods = 'CTRL' },
        pane
      )
    else
      -- Otherwise paste the clipboard into the terminal
      window:perform_action(
        wezterm.action.PasteFrom 'Clipboard',
        pane
      )
    end
  end),
},


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
