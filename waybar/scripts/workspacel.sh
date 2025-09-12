#!/bin/bash
# workspacel.sh - Left workspace group (1-2)
current=$(hyprctl activeworkspace -j | jq -r '.id')

case $current in
    1) text="<span color='#FF6B5A'>1</span> 2" ;;
    2) text="1 <span color='#FF6B5A'>2</span>" ;;
    *) text="1 2" ;;
esac

echo "{\"text\":\"$text\", \"class\":\"workspace-group\", \"tooltip\":\"Workspaces 1-2 | Active: $current\"}"

