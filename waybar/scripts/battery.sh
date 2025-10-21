#!/bin/bash
# ── battery.sh ─────────────────────────────────────────────
# Description: Shows battery % with ASCII bar + dynamic tooltip
# Usage: Waybar `custom/battery` every 10s
# Dependencies: upower, awk, seq, printf
#  ──────────────────────────────────────────────────────────

capacity=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

# Fallback if BAT0 not found (e.g., desktop)
if [ -z "$capacity" ]; then
    echo '{"text":"󰂑 AC", "tooltip":"Connected to AC power"}'
    exit 0
fi

# Get detailed info from upower
time_to_empty=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 2>/dev/null | awk -F: '/time to empty/ {print $2}' | xargs)
time_to_full=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 2>/dev/null | awk -F: '/time to full/ {print $2}' | xargs)

# Icons
charging_icons=(󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅)
default_icons=(󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)

index=$((capacity / 10))
[ $index -ge 10 ] && index=9

if [[ "$status" == "Charging" ]]; then
    icon=${charging_icons[$index]}
elif [[ "$status" == "Full" ]]; then
    icon="󰂅"
else
    icon=${default_icons[$index]}
fi

# ASCII bar
filled=$((capacity / 10))
empty=$((10 - filled))
bar=$(printf '█%.0s' $(seq 1 $filled))
pad=$(printf '░%.0s' $(seq 1 $empty))
ascii_bar="[$bar$pad]"

if [ "$capacity" -lt 30 ]; then
    fg="#ff6b5a"
elif [ "$capacity" -lt 50 ]; then
    fg="#ffb464"
else
    fg="#6aadc8"
fi

# Tooltip
tooltip="Battery: ${capacity}%\nStatus: ${status}"
if [ -n "$time_to_empty" ]; then
    tooltip+="\nTime to empty: $time_to_empty"
fi
if [ -n "$time_to_full" ]; then
    tooltip+="\nTime to full: $time_to_full"
fi

# Escape quotes for JSON
tooltip=$(printf '%s' "$tooltip" | sed 's/"/\\"/g')

# JSON output
echo "{\"text\":\"<span foreground='$fg'>$icon $ascii_bar $capacity%</span>\",\"tooltip\":\"$tooltip\"}"
