#!/usr/bin/env bash

confirm_action() {
	local action=$1
	# Return true (0) if action is confirmed, false (1) otherwise
	if [ "$WLOGOUT_CONFIRM" = "true" ]; then
		# Use wlroots-based dialog for Wayland compatibility
		if wofi --dmenu --width 300 --height 100 --prompt "Are you sure you want to $action?" --cache-file /dev/null <<<"No\nYes" | grep -q "Yes"; then
			return 0
		else
			return 1
		fi
	fi
}

shutdown_system() {
	pkexec systemctl poweroff
}

reboot_system() {
	pkexec systemctl reboot
}

hibernate_system() {
	pkexec systemctl hibernate
}

suspend_system() {
	pkexec systemctl suspend
}

lock_system() {
	pkexec loginctl lock-session
}

logout_system() {
	pkexec pkill .Hyprland-wrapp
}

# Check if a specific action was requested
case "$1" in
"shutdown")
	shutdown_system
	;;
"reboot")
	reboot_system
	;;
"hibernate")
	hibernate_system
	;;
"suspend")
	suspend_system
	;;
"lock")
	lock_system
	;;
"logout")
	logout_system
	;;
*)
	# If no argument is provided, show usage
	echo "Usage: $0 [shutdown|reboot|hibernate|suspend|lock|logout]"
	exit 1
	;;
esac

exit 0
