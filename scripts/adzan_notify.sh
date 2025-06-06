#!/usr/bin/env bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

cache_imsak=$(cat ~/.cache/eww/adzan/waktu_imsak)
cache_shubuh=$(cat ~/.cache/eww/adzan/waktu_shubuh)
cache_dzuhur=$(cat ~/.cache/eww/adzan/waktu_dzuhur)
cache_ashar=$(cat ~/.cache/eww/adzan/waktu_ashar)
cache_magrib=$(cat ~/.cache/eww/adzan/waktu_magrib)
cache_isya=$(cat ~/.cache/eww/adzan/waktu_isya)

TIME=$(date "+%H:%M")

case $TIME in
"$cache_imsak")
	notify-send "Imsak" "Waktu imsak telah tiba" -i "$HOME/.dots/scripts/mosque.svg"
	;;
"$cache_shubuh")
	notify-send "Shubuh" "Waktu shubuh telah tiba" -i "$HOME/.dots/scripts/mosque.svg"
	;;
"$cache_dzuhur")
	notify-send "Dzuhur" "Waktu dzuhur telah tiba" -i "$HOME/.dots/scripts/mosque.svg"
	;;
"$cache_ashar")
	notify-send "Ashar" "Waktu ashar telah tiba" -i "$HOME/.dots/scripts/mosque.svg"
	;;
"$cache_magrib")
	notify-send "Magrib" "Waktu magrib telah tiba" -i "$HOME/.dots/scripts/mosque.svg"
	;;
"$cache_isya")
	notify-send "Isya" "Waktu isya telah tiba" -i "$HOME/.dots/scripts/mosque.svg"
	;;
esac
