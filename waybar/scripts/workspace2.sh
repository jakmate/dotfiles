#!/bin/bash
# workspace2.sh - Single workspace indicator
source "$(dirname "$0")/colours.sh"

current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "2" ]; then
	echo "[<span color='$COLOR_LOW'>2</span>]"
else
	echo "[2]"
fi
