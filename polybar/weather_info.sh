#!/bin/sh

COL="${PB_VIOL}"
KEY="3f9128788c010e56faaa839f62ec30ad"
CITY=""
UNITS="metric"
SYMBOL="°C"

get_icon() {
    case $1 in
        01d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        01n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        02d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        02n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        03d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        03n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        04d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        04n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        09d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        09n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        10d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        10n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        11d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        11n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        13d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        13n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        50d) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        50n) icon="%{T3}%{F${COL}}%{F-}%{T-}";;
        *)   icon="%{T3}%{F${COL}}%{F-}%{T-}";
    esac

    echo $icon
}

get_duration() {

    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" -u +%H:%M;;
        *) date --date="@$1" -u +%H:%M;;
    esac

}

if [ ! -z $CITY ]; then
    current=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$CITY&units=$UNITS")
    forecast=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&id=$CITY&units=$UNITS&cnt=1")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ ! -z "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "http://api.openweathermap.org/data/2.5/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
        forecast=$(curl -sf "http://api.openweathermap.org/data/2.5/forecast?APPID=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
    fi
fi

if [ ! -z "$current" ] && [ ! -z "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    current_icon=$(echo "$current" | jq -r ".weather[].icon")

    forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[].icon")


    if [ "$current_temp" -gt "$forecast_temp" ]; then
        trend="%{T3}%{F${COL}}%{F-}%{T-}"
    elif [ "$forecast_temp" -gt "$current_temp" ]; then
        trend="%{T3}%{F${COL}}%{F-}%{T-}"
    else
        trend="%{T3}%{F${COL}}%{F-}%{T-}"
    fi


    sun_rise=$(echo "$current" | jq ".sys.sunrise")
    sun_set=$(echo "$current" | jq ".sys.sunset")
    now=$(date +%s)

    if [ "$sun_rise" -gt "$now" ]; then
        daytime="%{T3}%{F${COL}}%{F-}%{T-} $(get_duration "$(("$sun_rise"-"$now"))")"
    elif [ "$sun_set" -gt "$now" ]; then
        daytime="%{T3}%{F${COL}}%{F-}%{T-} $(get_duration "$(("$sun_set"-"$now"))")"
    else
        daytime="%{T3}%{F${COL}}%{F-}%{T-} $(get_duration "$(("$sun_rise"-"$now"))")"
    fi

    echo "$(get_icon "$current_icon") $current_temp$SYMBOL $trend $(get_icon "$forecast_icon") $forecast_temp$SYMBOL $daytime"
fi
