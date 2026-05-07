#!/usr/bin/env bash
# Pick a random image from ~/Pictures/Wallpapers and update the wallpaperPath
# in illogical-impulse config.json. Quickshell picks up the change automatically.

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CONFIG_FILE="$HOME/.config/illogical-impulse/config.json"

current=$(jq -r '.background.wallpaperPath' "$CONFIG_FILE" 2>/dev/null)

random_image=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    ! -path "$current" | shuf -n 1)

[ -z "$random_image" ] && exit 0

jq --arg path "$random_image" '.background.wallpaperPath = $path' "$CONFIG_FILE" \
    > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
