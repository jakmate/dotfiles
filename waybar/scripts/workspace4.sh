#!/bin/bash
# workspace4.sh - Single workspace indicator
current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "4" ]; then
    echo "[<span color='#FF6B5A'>4</span>]"
else
    echo "[4]"
fi