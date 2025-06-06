#!/usr/bin/env bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

## Collect data
cache_dir="$HOME/.cache/eww/adzan"
cache_adzan_imsak=${cache_dir}/waktu_imsak
cache_adzan_shubuh=${cache_dir}/waktu_shubuh
cache_adzhan_dzuhur=${cache_dir}/waktu_dzuhur
cache_adzan_ashar=${cache_dir}/waktu_ashar
cache_adzan_magrib=${cache_dir}/waktu_magrib
cache_adzan_isya=${cache_dir}/waktu_isya

TIME=$(date '+%d-%m-%Y')

## Make cache dir
if [[ ! -d "$cache_dir" ]]; then
	mkdir -p "${cache_dir}"
fi

## Get data
get_adzan_data() {
	adzan=$(curl -sf "https://api.aladhan.com/v1/timingsByAddress/$TIME?address=Depok%2C+INA&method=20&methodSettings=18.5%2Cnull%2C17.5%22")

	if [ ! -z "$adzan" ]; then
		adzan_imsak=$(echo "$adzan" | jq '.data.timings.Imsak' | tr -d '""')
		adzan_shubuh=$(echo "$adzan" | jq '.data.timings.Fajr' | tr -d '""')
		adzan_dzuhur=$(echo "$adzan" | jq '.data.timings.Dhuhr' | tr -d '""')
		adzan_ashar=$(echo "$adzan" | jq '.data.timings.Asr' | tr -d '""')
		adzan_magrib=$(echo "$adzan" | jq '.data.timings.Maghrib' | tr -d '""')
		adzan_isya=$(echo "$adzan" | jq '.data.timings.Isha' | tr -d '""')

		echo "$adzan_imsak" >"${cache_adzan_imsak}"
		echo "$adzan_shubuh" >"${cache_adzan_shubuh}"
		echo "$adzan_dzuhur" >"${cache_adzhan_dzuhur}"
		echo "$adzan_ashar" >"${cache_adzan_ashar}"
		echo "$adzan_magrib" >"${cache_adzan_magrib}"
		echo "$adzan_isya" >"${cache_adzan_isya}"
	else
		notify-send -a "adzan API" "Get Data Adzan" "Error when collect data! check your connection!" -i "$HOME/.icons/Kanagawa/status/48/stock_dialog-error.svg"
	fi
}

## Execute
get_adzan_data
case "$1" in
"--imsak")
	cat "${cache_adzan_imsak}"
	;;
"--shubuh")
	cat "${cache_adzan_shubuh}"
	;;
"--dzuhur")
	cat "${cache_adzhan_dzuhur}"
	;;
"--ashar")
	cat "${cache_adzan_ashar}"
	;;
"--maghrib")
	cat "${cache_adzan_magrib}"
	;;
"--isya")
	cat "${cache_adzan_isya}"
	;;
esac
