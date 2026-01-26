#!/bin/bash
# workspace1.sh - Single workspace indicator

source "$(dirname "$0")/colours.sh"

current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "1" ]; then
	echo "[<span color='$COLOR_LOW'>1</span>]"
else
	echo "[1]"
fi
