#!/bin/bash
# workspacer.sh - Right workspace group (3-4)  
current=$(hyprctl activeworkspace -j | jq -r '.id')

case $current in
    3) text="<span color='#FF6B5A'>3</span> 4" ;;
    4) text="3 <span color='#FF6B5A'>4</span>" ;;
    *) text="3 4" ;;
esac

echo "{\"text\":\"$text\", \"class\":\"workspace-group\", \"tooltip\":\"Workspaces 3-4 | Active: $current\"}"
