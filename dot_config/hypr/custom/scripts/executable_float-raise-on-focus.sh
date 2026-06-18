#!/bin/bash
# Bring floating windows to the front when they receive focus.
# Uses Hyprland's event socket to detect activewindow events.

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

socat -u "UNIX-CONNECT:$SOCKET" - | while read -r line; do
    if [[ "$line" =~ ^activewindow ]]; then
        if hyprctl -j activewindow 2>/dev/null | jq -e '.floating' > /dev/null; then
            hyprctl dispatch bringactivetotop > /dev/null
        fi
    fi
done
