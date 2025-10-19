#!/bin/bash
# workspace3.sh - Single workspace indicator
current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "3" ]; then
    echo "[<span color='#FF6B5A'>3</span>]"
else
    echo "[3]"
fi
