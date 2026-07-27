#!/bin/bash

weather_data=$(curl -fsS --max-time 3 "https://wttr.in?format=j1" 2>/dev/null | jq -er '[.current_condition[0].weatherCode, .weather[0].astronomy[0].sunrise, .weather[0].astronomy[0].sunset, .current_condition[0].temp_C] | select(all(. != null and . != "")) | @tsv' 2>/dev/null) || exit 1

IFS=$'\t' read -r weather_code sunrise sunset temp_c <<< "$weather_data"

now_epoch=$(date +%s)
sunrise_epoch=$(date -d "today $sunrise" +%s 2>/dev/null || echo 0)
sunset_epoch=$(date -d "today $sunset" +%s 2>/dev/null || echo 0)

if (( sunrise_epoch > 0 && sunset_epoch > 0 && (now_epoch < sunrise_epoch || now_epoch >= sunset_epoch) )); then
  night=true
else
  night=false
fi

case $weather_code in
  113) [[ $night == "true" ]] && icon="󰖔" || icon="󰌵" ;; # Clear / Sunny
  116) [[ $night == "true" ]] && icon="󰼱" || icon="󰖕" ;; # Partly Cloudy
  119|122) icon="󰖐" ;; # Cloudy / Overcast
  143|248|260) icon="󰖑" ;; # Fog / Mist
  176|263|266|293|296|353) icon="󰖗" ;; # Light Rain
  179|227|230|323|326|368) icon="󰼶" ;; # Light Snow
  182|185|281|284|311|314|317|320|350|362|365|374|377) icon="󰙿" ;; # Freezing Rain / Sleet
  200|386|389|392|395) icon="󰖓" ;; # Thunderstorm
  299|302|305|308|356|359) icon="󰖖" ;; # Heavy Rain
  329|332|335|338|371) icon="󰼶" ;; # Heavy Snow
  *) icon="󰖐" ;;
esac

if [[ -n $temp_c ]]; then
  printf '{"text":"%s %s°C"}\n' "$icon" "$temp_c"
else
  printf '{"text":"%s"}\n' "$icon"
fi
