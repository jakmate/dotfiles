#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
#  Wofi Power Menu
#  Provides a simple system power menu integrated with Waybar.
#  Example:
#      ./powermenu.sh
#      # Opens a Wofi menu with power options
# ─────────────────────────────────────────────────────────────────────────────

wofi_command="wofi --dmenu --lines=5 --width=20%"

options="Shutdown\nReboot\nLogout\nSuspend\nLock"

chosen="$(echo -e "$options" | $wofi_command)"
case $chosen in
Shutdown) systemctl poweroff ;;
Reboot) systemctl reboot ;;
Logout) hyprctl dispatch exit ;;
Suspend) systemctl suspend ;;
Lock) hyprlock ;;
esac
