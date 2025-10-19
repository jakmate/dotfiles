#!/bin/bash
# workspace1.sh - Single workspace indicator
current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "1" ]; then
    echo "[<span color='#FF6B5A'>1</span>]"
else
    echo "[1]"
fi