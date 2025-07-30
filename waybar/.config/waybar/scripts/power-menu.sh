#!/bin/bash

# Power menu script for waybar
# Using wofi and hyprlock

LAUNCHER="wofi --dmenu --hide-scroll --prompt --style ~/.config/wofi/power.css --width 300 --height 350 --hide-scroll --matching=fuzzy --insensitive"

# Power menu options
options="⏻ Shutdown\n⏾ Suspend\n⭘ Reboot\n⇠ Logout\n🔒 Lock"

# Show menu and get selection
chosen=$(echo -e "$options" | $LAUNCHER "Power Menu")

# Execute based on selection
case $chosen in
    "⏻ Shutdown")
        systemctl poweroff
        ;;
    "⏾ Suspend")
        systemctl suspend
        ;;
    "⭘ Reboot")
        systemctl reboot
        ;;
    "⇠ Logout")
        hyprctl dispatch exit
        ;;
    "🔒 Lock")
        hyprlock
        ;;
    *)
        # Do nothing if no valid option selected
        ;;
esac
