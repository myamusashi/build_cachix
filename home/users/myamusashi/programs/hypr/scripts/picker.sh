#!/bin/sh

color=$(hyprpicker -a)

FAILED="$HOME/.nix-profile/share/icons/Kanagawa/status/48/gtk-dialog-error.svg"
SUCCESS="$HOME/.nix-profile/share/icons/Kanagawa/apps/48/appimagekit-colorpicker.svg"

if [ -z "$color" ]; then
	notify-send -a "hyprpicker" "Hyprpicker" "Canceled. failed to get colors" -i "$FAILED";
	exit 0
fi

notify-send -a "hyprpicker" "Hyprpicker" "Get color: $color" -i "$SUCCESS"
