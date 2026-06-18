#!/bin/bash
# $1: r+1 or r-1
dir=$1

focused=$(hyprctl monitors -j | jq -r '.[] | select(.focused==true) | .name')

if [ "$dir" = "r+1" ]; then
    # 高いワークスペース番号から処理して競合を防ぐ
    monitors=$(hyprctl monitors -j | jq -r 'sort_by(-.activeWorkspace.id) | .[].name')
else
    # 低いワークスペース番号から処理して競合を防ぐ
    monitors=$(hyprctl monitors -j | jq -r 'sort_by(.activeWorkspace.id) | .[].name')
fi

for monitor in $monitors; do
    hyprctl dispatch focusmonitor "$monitor"
    hyprctl dispatch workspace "$dir"
done

hyprctl dispatch focusmonitor "$focused"
