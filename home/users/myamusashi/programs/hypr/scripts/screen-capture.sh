#!/usr/bin/env bash

wf-recorder_check() {
	if pgrep -x "wf-recorder" >/dev/null; then
		pkill -INT -x wf-recorder
		notify-send "Stopping all instances of wf-recorder" "$(cat /tmp/recording.txt)"
		wl-copy <"$(cat /tmp/recording.txt)"
		exit 0
	fi
}

SELECTION=$(echo -e "screenshot window\nscreenshot selection\nscreenshot eDP-1\nscreenshot HDMI-A-2\nscreenshot both screens" | fuzzel -d -p "󰄀 " -w 25 -l 6 -b e06c7510)

IMG="$HOME/Pictures/screenshot/$(date +%Y-%m-%d_%H-%m-%s).png"

goto_link() {
	ACTION=$(notify-send -a "Screen Capture" --action="default=open link" -i "$IMG" "Screenshot Taken" "${IMG}")

	if [ "$ACTION" == "default" ]; then
		foot --single-instance yazi $IMG
	fi
}

case "$SELECTION" in
"screenshot window")
	output=$(hyprshot -m window -d -s -o "$HOME/Pictures/screenshot/" -f "$(date +%Y-%m-%d_%H-%m-%s).png")
	if ! [[ "$output" =~ "selection cancelled" ]]; then
		wl-copy <"$IMG"
		mpg123 "$HOME/.dots/home/programs/hypr/scripts/camera-13695.mp3"
		sleep 1
		goto_link
	else
		notify-send -u critical -a "Screen Capture" "Screenshot Failed" "Failed to take screenshot."
	fi
	;;
"screenshot selection")
	grim -g "$(slurp)" "$IMG"
	if [ $? -eq 0 ]; then
		wl-copy <"$IMG"
		mpg123 "$HOME/.dots/home/programs/hypr/scripts/camera-13695.mp3"
		sleep 1
		goto_link
	else
		notify-send -u critical -a "Screen Capture" "Screenshot Failed" "Failed to take screenshot."
	fi
	;;
"screenshot eDP-1")
	sleep 2
	grim -c -o eDP-1 "$IMG"
	if [ $? -eq 0 ]; then
		wl-copy <"$IMG"
		mpg123 "$HOME/.dots/home/programs/hypr/scripts/camera-13695.mp3"
		goto_link
	else
		notify-send -u critical -a "Screen Capture" "Screenshot Failed" "Failed to take screenshot on eDP-1."
	fi
	;;
"screenshot HDMI-A-2")
	sleep 2
	grim -c -o HDMI-A-2 "$IMG"
	if [ $? -eq 0 ]; then
		wl-copy <"$IMG"
		goto_link
		mpg123 "$HOME/.dots/home/programs/hypr/scripts/camera-13695.mp3"
	else
		notify-send -u critical -a "Screen Capture" "Screenshot Failed" "Failed to take screenshot on HDMI-A-2."
	fi
	;;
"screenshot both screens")
	sleep 2
	grim -c -o eDP-1 "${IMG//.png/-eDP-1.png}"
	GRIM_EDP=$?
	grim -c -o HDMI-A-2 "${IMG//.png/-HDMI-A-2.png}"
	GRIM_HDMI=$?

	if [ $GRIM_EDP -eq 0 ] && [ $GRIM_HDMI -eq 0 ]; then
		montage "${IMG//.png/-eDP-1.png}" "${IMG//.png/-HDMI-A-2.png}" -tile 2x1 -geometry +0+0 "$IMG"
		wl-copy <"$IMG"
		rm "${IMG//.png/-eDP-1.png}" "${IMG//.png/-HDMI-A-2.png}"
		mpg123 "$HOME/.dots/home/programs/hypr/scripts/camera-13695.mp3"
		goto_link
	else
		notify-send -u critical -a "Screen Capture" "Screenshot Failed" "Failed to take screenshot on both screens."
	fi
	;;
*) ;;
esac
