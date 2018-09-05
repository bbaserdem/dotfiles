#!/usr/bin/bash

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_ora}"

# Check for internet
for ((_n=0;_n<10;_n++))
do
    # Try to ping OoenWeatherMap API service
    ping -c 1 -W 2 162.243.53.59 &>/dev/null
    [ "$?" -eq "0" ] && _n=10
    sleep 2
done

# Need a key, which I use my personal one. Please use your own if copying.
_key="3f9128788c010e56faaa839f62ec30ad"
# City can be defined to specify. If ocation is not available, will use this
_cit=""
# Define units here, I define it as celcius (metric), but kelvin (default) and fahrenheit (imperial) works.
_uni="metric"

# Get current weather and forecast
if [ ! -z "${_cit}" ]
then
    _cur=$(curl -sf 'http://api.openweathermap.org/data/2.5/weather?APPID='"${_key}"'&q='"${_cit}"'&units='"${_uni}")
    _for=$(curl -sf 'http://api.openweathermap.org/data/2.5/forecast?APPID='"${_key}"'&q='"${_cit}"'&units='"${_uni}"'cnt=1')
    _uvi=$(curl -sf 'http://api.openweathermap.org/data/2.5/uvi?APPID='"${_key}"'&q='"${_cit}")
else
    _loc=$(curl -sf 'https://location.services.mozilla.com/v1/geolocate?key=geoclue')
    if [ ! -z "${_loc}" ]
    then
        _lat="$(echo "${_loc}" | jq '.location.lat')"
        _lon="$(echo "${_loc}" | jq '.location.lng')"
        _cur=$(curl -sf 'http://api.openweathermap.org/data/2.5/weather?appid='"${_key}"'&lat='"${_lat}"'&lon='"$_lon"'&units='"${_uni}")
        _for=$(curl -sf 'http://api.openweathermap.org/data/2.5/forecast?APPID='"${_key}"'&lat='"${_lat}"'&lon='"${_lon}"'&units='"${_uni}"'&cnt=1')
        _uvi=$(curl -sf 'http://api.openweathermap.org/data/2.5/uvi?appid='"${_key}"'&lat='"${_lat}"'&lon='"$_lon")
    else
        _id="5128581" # Fallback city is New York
        _cur=$(curl -sf 'http://api.openweathermap.org/data/2.5/weather?APPID='"${_key}"'&id='"${_id}"'&units='"${_uni}")
        _for=$(curl -sf 'http://api.openweathermap.org/data/2.5/forecast?APPID='"${_key}"'&id='"${_id}"'&units='"${_uni}"'cnt=1')
        _uvi=$(curl -sf 'http://api.openweathermap.org/data/2.5/uvi?APPID='"${_key}"'&id='"${_id}")
    fi
fi

# If the things don't exit, quit
[ ! -z "${_cur}" ] || ( echo "<span color=${_col}></span>" && exit )


# FUNCTIONS
#   Use these to customize the weather prompt


#-----Temperature-----#
get_icon() {
    ov="$1"
    case $1 in
        01d) echo "<span foreground=${_col}></span>";;
        01n) echo "<span foreground=${_col}></span>";;
        02d) echo "<span foreground=${_col}></span>";;
        02n) echo "<span foreground=${_col}></span>";;
        03d) echo "<span foreground=${_col}></span>";;
        03n) echo "<span foreground=${_col}></span>";;
        04d) echo "<span foreground=${_col}></span>";;
        04n) echo "<span foreground=${_col}></span>";;
        09d) echo "<span foreground=${_col}></span>";;
        09n) echo "<span foreground=${_col}></span>";;
        10d) echo "<span foreground=${_col}></span>";;
        10n) echo "<span foreground=${_col}></span>";;
        11d) echo "<span foreground=${_col}></span>";;
        11n) echo "<span foreground=${_col}></span>";;
        13d) echo "<span foreground=${_col}></span>";;
        13n) echo "<span foreground=${_col}></span>";;
        50d) echo "<span foreground=${_col}></span>";;
        50n) echo "<span foreground=${_col}></span>";;
        null) echo "<span foreground=${_col}></span>";;
        *)   echo "<span foreground=${_col}>$ov</span>";;
    esac
}
prompt_temp () {
    _tem_ico=""

    _cur_tem="$(echo "${_cur}" | jq -r '.main."temp"' | awk '{printf("%.1f",$1)}')"
    # Check if current temperature is OK
    [ "${_cur_tem}" == "null" ] && exit
    _tem_ico_cur="<span foreground=${_col}>\
        $(get_icon "$(echo "${_cur}" | jq -r ".weather[].icon")")</span>"

    echo "${_tem_ico_cur} ${_cur_tem}"
}
prompt_temp_trend () {
    _tem_ico="糖"

    _cur_tem="$(echo "${_cur}" | jq -r '.main."temp"' | awk '{printf("%.1f",$1)}')"
    # Check if current temperature is OK
    [ "${_cur_tem}" == "null" ] && exit
    _tem_ico_cur="$(get_icon "$(echo "${_cur}" | jq -r '.weather[]."icon"')")"

    _for_tem="$(echo "${_for}" | jq -r '.list[].main."temp"' | awk '{printf("%.1f",$1)}')"
    # If forecast temperature is null, print and exit
    ( [ "${_for_tem}" == "null" ] && echo "${_tem_ico_cur} ${_cur_tem}" ) && exit
    _tem_ico_for="$(get_icon "$(echo "${_for}" | jq -r '.list[].weather[]."icon"')")"
    
    # Draw trend arrows
    if   (( $(echo "${_cur_tem} > ${_for_tem}" | bc -l) )); then
        _tem_ico_trn="<span foreground=${_col}></span>"
    elif (( $(echo "${_cur_tem} < ${_for_tem}" | bc -l) )); then
        _tem_ico_trn="<span foreground=${_col}></span>"
    else
        _tem_ico_trn="<span foreground=${_col}></span>"
    fi
    echo "${_tem_ico_cur} ${_cur_tem}${_tem_ico} ${_tem_ico_trn}${_tem_ico_for} ${_for_tem}${_tem_ico}"
}



#-----Cloud-----#
prompt_cloud () {
    _clo_ico="<span color=${_col}></span>"

    # Check if data is null
    _cur_clo="$(echo "${_cur}" | jq -r '.clouds."all"')"
    [ "${_cur_clo}" == "null" ] && exit

    echo "${_clo_ico} ${_cur_clo}"
}
prompt_cloud_trend () {
    _clo_ico="<span color=${_col}></span>"

    # Check if data is null
    _cur_clo="$(echo "${_cur}" | jq -r '.clouds."all"')"
    [ "${_cur_clo}" == "null" ] && exit

    # Check if forecast is available
    _for_clo="$(echo "${_for}" | jq -r '.list[].clouds."all"')"
    ( [ "${_for_clo}" == "null" ] && echo "${_clo_ico} ${_cur_clo}" ) && exit
    
    # Do trend arrow, or dont
    if [ "${_cur_clo}" == "${_for_clo}" ]
    then
        echo "${_clo_ico} ${_cur_clo}"
    else
        if   [ "$_cur_clo" -gt "$_for_clo" ]
        then
            _clo_trn="<span foreground=${_col}></span>"
        else 
            _clo_trn="<span foreground=${_col}></span>"
        fi
        echo "${_clo_ico} ${_cur_clo}${_clo_trn}${_for_clo}"
    fi
}


#-----Humidity-----#
prompt_humidity () {
    _hum_ico="<span color=${_col}></span>"

    # Check if data is null
    _cur_hum="$(echo "${_cur}" | jq -r '.main."humidity"')"
    [ "${_cur_hum}" == "null" ] && exit
    
    echo "${_hum_ico} ${_cur_hum}"
}
prompt_humidity_trend () {
    _hum_ico="<span color=${_col}></span>"

    # Check if data is null
    _cur_hum="$(echo "${_cur}" | jq -r '.main."humidity"')"
    [ "${_cur_hum}" == "null" ] && exit

    # Check if forecast is available
    _for_hum="$(echo "${_for}" | jq -r '.list[].main."humidity"')"
    ( [ "${_for_hum}" == "null" ] && echo "${_hum_ico} ${_cur_hum}" ) && exit

    # Do trend arrow if there is a trend
    if [ "${_cur_hum}" == "${_for_hum}" ]; then
        echo "${_hum_ico} ${_cur_hum}"
    else
        if   [ "${_cur_hum}" -gt "${_for_hum}" ]; then
            _hum_trn="<span foreground=${_col}></span>"
        else 
            _hum_trn="<span foreground=${_col}></span>"
        fi
        echo "${_hum_ico} ${_cur_hum}${_hum_trn}${_for_hum}"
    fi
}


#-----Wind-----#
prompt_wind () {
    # Check if current wind data is available
    _cur_win="$(echo "${_cur}" | jq -r '.wind."speed"' | awk '{printf("%.1f",$1)}')"
    _cur_dir="$(echo "${_cur}" | jq -r '.wind."deg"')"
    [ "${_cur_win}" == "null" ] && exit

    # Check direction
    if   [ "${_cur_dir}" == "null" ]; then
        _dir_ico_cur=""
    elif [ "${_cur_dir}" -lt "23" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    elif [ "${_cur_dir}" -lt "68" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    elif [ "${_cur_dir}" -lt "113" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    elif [ "${_cur_dir}" -lt "158" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    elif [ "${_cur_dir}" -lt "203" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    elif [ "${_cur_dir}" -lt "248" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    elif [ "${_cur_dir}" -lt "293" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    elif [ "${_cur_dir}" -lt "338" ]; then
        _dir_ico_cur="<span color=${_col}></span>"
    else
        _dir_ico_cur="<span color=${_col}></span>"
    fi

    # If it exists, do a beaufort scale comparison
    if [ "${_uni}" == "imperial" ]
    then
        if   (( $(echo "${_cur_win} <=  1" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <=  3" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <=  7" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 12" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 18" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 24" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 31" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 38" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 46" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 54" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 63" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 72" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        else
            _win_ico="<span color=${_col}></span>"
        fi
    else
        if   (( $(echo "${_cur_win} <= 00.3" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 01.5" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 03.3" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 05.5" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 07.9" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 10.7" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 13.8" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 17.1" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 20.7" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 24.4" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 28.4" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        elif (( $(echo "${_cur_win} <= 32.6" | bc -l) )); then
            _win_ico="<span color=${_col}></span>"
        else
            _win_ico="<span color=${_col}></span>"
        fi
    fi

    echo "${_win_ico} ${_cur_win}${_dir_ico_cur}" && exit
}
prompt_wind_trend () {
    # Get previous prompt
    _curprom="$(prompt_wind)"
    [ -z "${_curprom}" ] && exit

    # Get forecast wind
    _for_win="$(echo "${_for}" | jq -r '.list[].wind."speed"' | awk '{printf("%.1f",$1)}')"
    _for_dir="$(echo "${_for}" | jq -r '.list[].wind."deg"')"

    ( [ "${_for_win}" == "null" ] && echo "${_cumprom}" ) && exit

    # Check direction
    if   [ "${_for_dir}" == "null" ]; then
        _dir_ico_for=""
    elif [ "${_for_dir}" -lt "23" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    elif [ "${_for_dir}" -lt "68" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    elif [ "${_for_dir}" -lt "113" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    elif [ "${_for_dir}" -lt "158" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    elif [ "${_for_dir}" -lt "203" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    elif [ "${_for_dir}" -lt "248" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    elif [ "${_for_dir}" -lt "293" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    elif [ "${_for_dir}" -lt "338" ]; then
        _dir_ico_for="<span color=${_col}></span>"
    else
        _dir_ico_for="<span color=${_col}></span>"
    fi
    [ "${_cur_win}" == "null" ] && exit

    echo "${_curprom} ${_for_win}${_dir_ico_for}"
}

#-----Precipitation-----#
prompt_precipitation () {
    # Check for rain
    _cur_pre="$(echo "${_cur}" | jq -r '.rain."3h"')"
    _cur_sno="$(echo "${_cur}" | jq -r '.snow."3h"')"
    
    # If none, quit
    ( [ "${_cur_pre}" = "null" ] && [ "${_cur_sno}" = "null" ] ) && exit

    if [ ! "${_cur_sno}" = "null" ]; then
        echo "<span color=${_col}></span> ${_cur_sno}"
    else
        echo "<span color=${_col}></span> ${_cur_pre}"
    fi
}
prompt_precipitation_trend () {
    # Check for rain
    _cur_pre="$(echo "${_cur}" | jq -r '.rain."3h"')"
    _cur_sno="$(echo "${_cur}" | jq -r '.snow."3h"')"
    
    # If none, quit
    ( [ "${_cur_pre}" = "null" ] && [ "${_cur_sno}" = "null" ] ) && exit

    if [ ! "${_cur_sno}" = "null" ]; then
        _curprom="<span color=${_col}></span> ${_cur_sno}"
    else
        _curprom="<span color=${_col}></span> ${_cur_pre}"
    fi

    # Check for rain
    _for_pre="$(echo "${_for}" | jq -r '.list[].rain."3h"')"
    _for_sno="$(echo "${_for}" | jq -r '.list[].snow."3h"')"
    
    # If none, quit
    if [ "${_for_pre}" = "null" ] && [ "${_for_sno}" = "null" ]
    then
        echo "${_curprom}"
    elif [ ! "${_for_sno}" = "null" ]; then
        echo "${_curprom=} <span color=${_col}></span> ${_for_sno}"
    else
        echo "${_curprom=} <span color=${_col}></span> ${_for_sno}"
    fi
}


#-----Sunrise-----#
get_duration () {
    date --date="@$1" -u +%H:%M
}
prompt_suntime (){
    _sup="$(echo "${_cur}" | jq -r '.sys."sunrise"')"
    _sdn="$(echo "${_cur}" | jq -r '.sys."sunset"')"
    _now=$(date +%s)
    if [ "${_sup}" -gt "${_now}" ]
    then
        echo "<span foreground=${_col}></span> $(get_duration $(("${_sup}"-"${_now}")))"
    elif [ "${_sdn}" -gt "${_now}" ]
    then
        echo "<span foreground=${_col}></span> $(get_duration $(("${_sdn}"-"${_now}")))"
    else
        echo "<span foreground=${_col}></span> $(get_duration $(("${_sup}"-"${_now}")))"
    fi
}


#-----Visibility-----#
prompt_visibility () {
    _vis_ico="<span color=${_col}></span>"

    _cur_vis="$(echo "${_cur}" | jq -r '."visibility"')"
    # Check if current temperature is OK
    [ "${_cur_vis}" == "null" ] && exit

    echo "${_vis_ico} ${_cur_vis}"
}
prompt_visibility_trend () {
    _vis_ico="<span color=${_col}></span>"

    _cur_vis="$(echo "${_cur}" | jq -r '."visibility"')"
    # Check if current temperature is OK
    [ "${_cur_vis}" == "null" ] && exit

    _for_vis="$(echo "${_for}" | jq -r '.list[]."visibility"')"
    # If forecast temperature is null, print and exit
    if [ "${_for_vis}" == "null" ] || [ "${_for_vis} == "${_cur_vis} ]
    then
        echo "${_vis_ico} ${_cur_vis}"
    elif (( $(echo "${_cur_vis} > ${_for_vis}" | bc -l) ))
    then
        echo "${_vis_ico} ${_cur_vis} <span foreground=${_col}></span> ${_for_vis}"
    else
        echo "${_vis_ico} ${_cur_vis} <span foreground=${_col}></span> ${_for_vis}"
    fi
}



#-----Pressure-----#
prompt_pressure () {
    _pre_ico="<span color=${_col}></span>"

    _cur_pre="$(echo "${_cur}" | jq -r '.main."pressure"')"
    # Check if current pressure is OK
    [ "${_cur_pre}" == "null" ] && exit

    echo "${_pre_ico} ${_cur_pre}"
}
prompt_pressure_trend () {
    _pre_ico="<span color=${_col}></span>"

    _cur_pre="$(echo "${_cur}" | jq -r '.main."pressure"')"
    # Check if current pressure is OK
    [ "${_cur_pre}" == "null" ] && exit

    _for_pre="$(echo "${_for}" | jq -r '.list[].main."pressure"')"
    # If forecast temperature is null, print and exit
    if [ "${_for_pre}" == "null" ] || [ "${_for_pre} == "${_cur_pre} ]
    then
        echo "${_pre_ico} ${_cur_pre}"
    elif (( $(echo "${_cur_pre} > ${_for_pre}" | bc -l) ))
    then
        echo "${_pre_ico} ${_cur_pre}<span foreground=${_col}></span>${_for_pre}"
    else
        echo "${_pre_ico} ${_cur_pre}<span foreground=${_col}></span>${_for_pre}"
    fi
}



#-----UV Index-----#
prompt_uv_index () {
    _uvi_ico="<span color=${_col}>碌</span>"
    _uvi_txt="$(echo "${_uvi}" | jq -r '."value"')"
    [ "${_uvi_txt}" == "null" ] || echo "${_uvi_ico} ${_uvi_txt}"
}


echo "$(prompt_temp_trend) $(prompt_humidity) $(prompt_uv_index) $(prompt_suntime)"
