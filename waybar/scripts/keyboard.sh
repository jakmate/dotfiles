#!/usr/bin/env bash

# Layout order (must match Hyprland config)
layouts=("gb" "pl" "jp")

# Labels to show in Waybar
declare -A labels=(
  ["gb"]="GB"
  ["pl"]="PL"
  ["jp"]="JP"
)

# Get current keymap name
current=$(hyprctl devices -j | jq -r '
  .keyboards[]
  | select(.main == true)
  | .active_keymap
')

# Normalize to layout codes
case "$current" in
*English*UK* | *English*United*Kingdom*) cur="gb" ;;
*Polish*) cur="pl" ;;
*Japanese*) cur="jp" ;;
*) cur="gb" ;;
esac

# Find index
for i in "${!layouts[@]}"; do
  [[ "${layouts[$i]}" == "$cur" ]] && index=$i
done

# Rotate layout on click
if [[ "$1" == "next" ]]; then
  hyprctl switchxkblayout main next
  exit 0
fi

# Plain text output
echo "[ ${labels[$cur]} ]"
