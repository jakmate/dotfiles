#!/bin/bash
# ── mic.sh ─────────────────────────────────────────────────
# Description: Shows microphone mute/unmute status with icon
# Usage: Called by Waybar `custom/microphone` module every 1s
# Dependencies: pactl (PulseAudio / PipeWire)
# ───────────────────────────────────────────────────────────

# Source colours file
source "$(dirname "$0")/colours.sh"

if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q 'yes'; then
  # Muted → mic-off icon
  echo "<span foreground='$COLOR_LOW'>[  ]</span>"
else
  # Active → mic-on icon
  echo "<span foreground='$COLOR_HIGH'>[  ]</span>"
fi
