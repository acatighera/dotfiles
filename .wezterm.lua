local wezterm = require("wezterm")

local function is_vim(pane)
  -- The Neovim smart-splits plugin exports this flag on entry.
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function split_nav(resize_or_move, key)
  local mods = resize_or_move == "resize" and "META" or "CTRL"
  return {
    key = key,
    mods = mods,
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        win:perform_action({
          SendKey = { key = key, mods = mods },
        }, pane)
        return
      end

      if resize_or_move == "resize" then
        win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
      else
        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end),
  }
end

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font_with_fallback({
  "FiraCode Nerd Font",
  "JetBrainsMono Nerd Font",
})
config.font_size = 13.5
config.line_height = 1.1
config.window_padding = {
  left = 12,
  right = 12,
  top = 8,
  bottom = 8,
}
config.window_background_opacity = 0.93
config.text_background_opacity = 1.0
if wezterm.target_triple:find("darwin") then
  config.macos_window_background_blur = 20
end
config.enable_scroll_bar = false
config.check_for_updates = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"
config.default_cursor_style = "BlinkingUnderline"
config.animation_fps = 120
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"

config.disable_default_key_bindings = true

config.keys = {
  { key = "F11", action = wezterm.action.ToggleFullScreen },
  {
    key = "T",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "N",
    mods = "CTRL",
    action = wezterm.action.SpawnWindow,
  },
  {
    key = "S",
    mods = "CTRL|SHIFT",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "S",
    mods = "CTRL",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),
  {
    key = "W",
    mods = "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  {
    key = "P",
    mods = "CTRL|SHIFT",
    action = wezterm.action.QuickSelect,
  },
  {
    key = "L",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ShowLauncher,
  },
  {
    key = "c",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local selection_text = window:get_selection_text_for_pane(pane)
      if selection_text and #selection_text > 0 then
        window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
      else
        window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
      end
    end),
  },
  {
    key = "v",
    mods = "CTRL",
    action = wezterm.action_callback(function(window, pane)
      local proc = pane:get_foreground_process_name() or ""
      local title = pane:get_title()
      local inside_vim = proc:match("n?vim") or title:match("NVIM")

      if inside_vim then
        window:perform_action(wezterm.action.SendKey({ key = "v", mods = "CTRL" }), pane)
      else
        window:perform_action(wezterm.action.PasteFrom("Clipboard"), pane)
      end
    end),
  },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action_callback(function(window, pane)
      local has_selection = window:get_selection_text_for_pane(pane) ~= ""
      if has_selection then
        window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action("ClearSelection", pane)
      else
        window:perform_action(wezterm.action.PasteFrom("Clipboard"), pane)
      end
    end),
  },
}

-- Handy key table for quickly switching workspaces without colliding with tmux.
config.key_tables = {
  resize = {
    { key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 3 }) },
    { key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 3 }) },
    { key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 3 }) },
    { key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 3 }) },
    { key = "Escape", action = "PopKeyTable" },
  },
}

config.quick_select_patterns = {
  "[0-9a-f]{7,}",
  "https?://\\S+",
}

return config
