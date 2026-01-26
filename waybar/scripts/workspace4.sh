#!/bin/bash
# workspace4.sh - Single workspace indicator
source "$(dirname "$0")/colours.sh"

current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "4" ]; then
	echo "[<span color='$COLOR_LORW'>4</span>]"
else
	echo "[4]"
fi
