#!/usr/bin/env bash
set -euo pipefail

WTYPE=/usr/bin/wtype
GDBUS=/usr/bin/gdbus

get_class() {
  "$GDBUS" call --session \
    --dest org.gnome.Shell \
    --object-path /org/gnome/Shell \
    --method org.gnome.Shell.Eval \
    "global.display.focus_window ? global.display.focus_window.get_wm_class() : ''" \
    | awk -F"'" '{print $2}'
}

cls="$(get_class || echo "")"

if [ "$cls" = "WezTerm" ] || [ "$cls" = "org.wezfurlong.wezterm" ]; then
  exit 0
fi

# Forward Alt+V -> Ctrl+V
exec "$WTYPE" -M ctrl -k v -m ctrl

