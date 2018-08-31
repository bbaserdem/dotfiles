#!/usr/bin/bash

_key="3f9128788c010e56faaa839f62ec30ad"
_city=""
_unit="metric"
_symbol="°C"
_color="'$(/usr/bin/xgetres i3.orang)'"

sleep 10

get_icon() {
    case $1 in
        01d) icon="";;
        01n) icon="";;
        02d) icon="";;
        02n) icon="";;
        03d) icon="";;
        03n) icon="";;
        04d) icon="";;
        04n) icon="";;
        09d) icon="";;
        09n) icon="";;
        10d) icon="";;
        10n) icon="";;
        11d) icon="";;
        11n) icon="";;
        13d) icon="";;
        13n) icon="";;
        50d) icon="";;
        50n) icon="";;
        *)   icon="";;
    esac

    echo '<span foreground='"$_color"'>'"$icon"'</span>'
}

get_duration() {
    date --date="@$1" -u +%H:%M
}

if [ ! -z $_city ]; then
    current=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$_key&id=$_city&units=$_unit")
    forecast=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$_key&id=$_city&units=$_unit&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ ! -z "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$_key&lat=$location_lat&lon=$location_lon&units=$_unit")
        forecast=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$_key&lat=$location_lat&lon=$location_lon&units=$_unit&cnt=1")
    fi
fi

if [ ! -z "$current" ] && [ ! -z "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    current_icon=$(echo "$current" | jq -r ".weather[].icon")

    forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[].icon")


    if [ "$current_temp" -gt "$forecast_temp" ]; then
        trend='<span foreground='"$_color"'></span>'
    elif [ "$forecast_temp" -gt "$current_temp" ]; then
        trend='<span foreground='"$_color"'></span>'
    else
        trend='<span foreground='"$_color"'></span>'
    fi


    sun_rise=$(echo "$current" | jq ".sys.sunrise")
    sun_set=$(echo "$current" | jq ".sys.sunset")
    now=$(date +%s)

    if [ "$sun_rise" -gt "$now" ]
    then
        daytime='<span foreground='"$_color"'></span> '"$(get_duration $(("$sun_rise"-"$now")))"
    elif [ "$sun_set" -gt "$now" ]
    then
        daytime='<span foreground='"$_color"'></span> '"$(get_duration $(("$sun_set"-"$now")))"
    else
        daytime='<span foreground='"$_color"'></span> '"$(get_duration $(("$sun_rise"-"$now")))"
    fi

    echo "$(get_icon "$current_icon") $current_temp$_symbol $trend $(get_icon "$forecast_icon") $forecast_temp$_symbol $daytime"
fi
