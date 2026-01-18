#!/bin/bash
# workspace3.sh - Single workspace indicator
source "$(dirname "$0")/colours.sh"

current=$(hyprctl activeworkspace -j | jq -r '.id')

if [ "$current" = "3" ]; then
  echo "[<span color='$COLOR_LOW'>3</span>]"
else
  echo "[3]"
fi
