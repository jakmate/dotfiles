#!/bin/bash
# workspace2.sh - Single workspace indicator
current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "2" ]; then
    echo "[<span color='#FF6B5A'>2</span>]"
else
    echo "[2]"
fi