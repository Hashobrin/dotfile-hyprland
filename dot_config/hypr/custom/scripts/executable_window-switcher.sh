#!/usr/bin/env bash
# Switch to any window across all workspaces using fuzzel

selected=$(hyprctl clients -j | jq -r '.[] | "\(.title)\t[\(.class)] ws:\(.workspace.name)\t\(.address)"' | \
  awk -F'\t' '{ printf "%-50s %s\n", $1, $2 }' | \
  fuzzel --dmenu --prompt="Window: ")

[ -z "$selected" ] && exit 0

title=$(echo "$selected" | sed 's/  \+\[.*//')
address=$(hyprctl clients -j | jq -r --arg title "$title" '.[] | select(.title == $title) | .address' | head -1)

[ -z "$address" ] && exit 1

hyprctl dispatch focuswindow "address:$address"
