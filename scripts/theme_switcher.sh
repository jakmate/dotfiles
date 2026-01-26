THEMES=("default" "mazda")
DISPLAY_NAMES=("Default theme" "Mazda theme")

OPTIONS=""
for i in "${!THEMES[@]}"; do
  OPTIONS+="${DISPLAY_NAMES[i]}\n"
done

SELECTED=$(echo -e "$OPTIONS" | wofi --dmenu --lines=5 --width=30%)

if [[ $SELECTED == "Default theme" ]]; then
  THEME="default"
elif [[ $SELECTED == "Mazda theme" ]]; then
  THEME="mazda"
else
  echo "No valid selection made."
  exit 1
fi

cp "$HOME/.config/wofi/themes/$THEME.css" "$HOME/.config/wofi/style.css"
cp "$HOME/.config/hypr/themes/hyprpaper/$THEME.conf" "$HOME/.config/hypr/hyprpaper.conf"
cp "$HOME/.config/hypr/themes/hyprlock/$THEME.conf" "$HOME/.config/hypr/hyprlock.conf"
cp "$HOME/.config/fastfetch/themes/$THEME.jsonc" "$HOME/.config/fastfetch/config.jsonc"
cp "$HOME/.config/waybar/themes/$THEME.css" "$HOME/.config/waybar/style.css"
cp "$HOME/.config/waybar/themes/$THEME.sh" "$HOME/.config/waybar/scripts/colours.sh"
cp "$HOME/.config/kitty/themes/$THEME.conf" "$HOME/.config/kitty/kitty.conf"
cp "$HOME/.config/dunst/themes/$THEME" "$HOME/.config/dunst/dunstrc"

# Extracting the wallpaper path from the configuration
WALLPAPER_PATH=$(grep 'path =' "$HOME/.config/hypr/hyprpaper.conf" | cut -d'=' -f2 | tr -d ' ')

# Expand the tilde to the full home path
FULL_WALLPAPER_PATH="${WALLPAPER_PATH/#\~/$HOME}"

if [[ -n $FULL_WALLPAPER_PATH ]]; then
  hyprctl hyprpaper wallpaper "eDP-1, $FULL_WALLPAPER_PATH, cover"
else
  echo "Wallpaper path not found in configuration."
fi

killall dunst && dunst &
killall waybar && waybar &
hyprctl reload

echo "Switched to $THEME theme"
