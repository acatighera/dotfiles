#!/usr/bin/env bash
set -euo pipefail

WTYPE=/usr/bin/wtype
GDBUS=/usr/bin/gdbus

# Detect focused window's WM_CLASS via GNOME/COSMIC Shell
get_class() {
  "$GDBUS" call --session \
    --dest org.gnome.Shell \
    --object-path /org/gnome/Shell \
    --method org.gnome.Shell.Eval \
    "global.display.focus_window ? global.display.focus_window.get_wm_class() : ''" \
    | awk -F"'" '{print $2}'
}

cls="$(get_class || echo "")"

# Skip if it's WezTerm
if [ "$cls" = "WezTerm" ] || [ "$cls" = "org.wezfurlong.wezterm" ]; then
  exit 0
fi

# Forward Alt+C -> Ctrl+C
exec "$WTYPE" -M ctrl -k c -m ctrl

