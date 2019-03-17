#!/bin/sh

# Default to base16-default-dark
_mute="'${base03:-#585858}'"
col_red="'${base08:-#ab4642}'"
col_ora="'${base09:-#dc9656}'"
col_yel="'${base0A:-#f7ca88}'"
col_gre="'${base0B:-#a1b56c}'"
col_cya="'${base0C:-#86c1b9}'"
col_ind="'${base0D:-#7cafc2}'"
col_vio="'${base0E:-#ba8baf}'"
col_bro="'${base0F:-#a16946}'"

battery () {
    _cap="/sys/class/power_supply/BAT0/capacity"
    _stt="/sys/class/power_supply/BAT0/status"
    _onl="/sys/class/power_supply/AC0/online"
    
    get_text () {
        _num="$(cat ${_cap})"
        _sta="$(cat ${_stt})"
        _acp="$(cat ${_onl})"

        if   [ "$_num" -ge 80 ] ; then
            # Green ()
            _col="${col_gre}"
            _ico=""
        elif [ "$_num" -ge 60 ] ; then
            # Yellow (0A)
            _col="${col_yel}"
            _ico=""
        elif [ "$_num" -ge 40 ] ; then
            # Orange (09)
            _col="${col_ora}"
            _ico=""
        elif [ "$_num" -ge 20 ] ; then
            # Red (08)
            _col="${col_red}"
            _ico=""
        else
            # White (03)
            _col="${col_bro}"
            _ico=""
        fi

        if [ "$_sta" = "Charging" ] ; then
            _ico=${_ico:1:2}
        elif [ "$_acp" = "1" ] ; then
            _ico=""
        else
            _ico=${_ico:0:1}
        fi

        echo "<span color=${_col}>${_ico}</span> ${_num}%" | sed 's|&|&amp;|g'
    }

    while : ; do
        get_text
        sleep .2
        inotifywait --timeout -1 "${_cap}" "${_stt}" "${_onl}" > /dev/null 2>&1 || break
    done

}

brightness () {
    _file="/sys/class/backlight/${BRI_SCR}/brightness"
    _col="${col_vio}"

    get_text () {
        _val="$(brightnessctl -d $BRI_SCR i | grep Current | sed 's|.*(\(.*\)%)|\1|')" || exit

        if   [ "$_val" -ge 75 ] ; then
            _icon=""
        elif [ "$_val" -ge 50 ] ; then
            _icon=""
        else
            _icon=""
        fi

        [ -z "${_val}" ] || echo '<span color='"$_col"'>'"$_icon"'</span> '"$_val"'%' | sed 's|&|&amp;|g'
    }
    
    get_loop () {
        while : ; do
            get_text
            sleep .2
            inotifywait --timeout -1 "${_file}" > /dev/null 2>&1 || break
        done
    }

    get_loop &
    while read button ; do
        case $button in
            4) /usr/bin/brightnessctl -d $BRI_SCR s +5% > /dev/null 2>&1 ;;
            5) /usr/bin/brightnessctl -d $BRI_SCR s 5%- > /dev/null 2>&1 ;;
        esac
    done
}

calendar () {
    # Doesn't work infinite loop
    _file="${HOME}/Documents/Calendar"
    _col="${col_bro}"
    _ico=""
    _len=52

    get_text () {
        _txt="$(khal list | head -n 1)"
        [ "${#_txt}" -gt "${_len}" ] && _txt="${_txt:0:${_len}}…"
        [ "${_txt}" = "No events" ]  && _txt="<span color=${_mute}>${_txt}</span>"
        echo "<span color=${_col}>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g'
    }

    get_loop () {
        while : ; do
            get_text
            sleep 5
            inotifywait --recursive --timeout -1 "${_file}" > /dev/null 2>&1 || break
        done
    }

    get_loop
}

cpu () {
    _col="${col_yel}"
    _ico=""
    _cpu1="$(grep 'cpu ' /proc/stat)"

    while : ; do
        sleep 1
        _cpu2="$(grep 'cpu ' /proc/stat)"
        _per="$( echo "${_cpu1} ${_cpu2}" | awk '{ printf( "%.2f", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)) }' )"
        _cpu1="${_cpu2}"
        echo "<span color=${_col}>${_ico}</span> ${_per}%" | sed 's|&|&amp;|g'
    done
}

day () {
    _col="${col_ind}"
    get_light () {
        case "$1" in
            0|30)   echo "" ;;
            1)      echo "" ;;
            2)      echo "" ;;
            3)      echo "" ;;
            4)      echo "" ;;
            5)      echo "" ;;
            6)      echo "" ;;
            7)      echo "" ;;
            8)      echo "" ;;
            9)      echo "" ;;
            10)     echo "" ;;
            11)     echo "" ;;
            12)     echo "" ;;
            13)     echo "" ;;
            14)     echo "" ;;
            15)     echo "" ;;
            16)     echo "" ;;
            18)     echo "" ;;
            19)     echo "" ;;
            20)     echo "" ;;
            21)     echo "" ;;
            22)     echo "" ;;
            23)     echo "" ;;
            24)     echo "" ;;
            25)     echo "" ;;
            26)     echo "" ;;
            27)     echo "" ;;
            28)     echo "" ;;
            29)     echo "" ;;
        esac
    }

    get_dark () {
        case "$1" in
            0|30)   echo "" ;;
            1)      echo "" ;;
            2)      echo "" ;;
            3)      echo "" ;;
            4)      echo "" ;;
            5)      echo "" ;;
            6)      echo "" ;;
            7)      echo "" ;;
            8)      echo "" ;;
            9)      echo "" ;;
            10)     echo "" ;;
            11)     echo "" ;;
            12)     echo "" ;;
            13)     echo "" ;;
            14)     echo "" ;;
            15)     echo "" ;;
            16)     echo "" ;;
            18)     echo "" ;;
            19)     echo "" ;;
            20)     echo "" ;;
            21)     echo "" ;;
            22)     echo "" ;;
            23)     echo "" ;;
            24)     echo "" ;;
            25)     echo "" ;;
            26)     echo "" ;;
            27)     echo "" ;;
            28)     echo "" ;;
            29)     echo "" ;;
        esac
    }

    get_lunar () {
        _days=$(python -c 'from datetime import date as d;print((d.today()-d(1999,8,11)).days)')
        _moon="$(echo "${_days} % 29.530588853" | bc | awk '{printf("%d",$1+.5)}')"
        echo "<span color=${_col}>$(get_dark "${_moon}")</span>"
    }

    get_text () {
        echo "$(get_lunar) $(date '+%a %d, %b %Y')" | sed 's|&|&amp;|g'
    }

    get_loop () {
        while : ; do
            get_text
            sleep "$(( $(date -d "tomorrow 0" +%s) - $(date +%s) + 5 ))"
        done
    }

    get_loop
}

disk () {
    _col="${col_bro}"
    _icr=""
    _ich=""
    _rfs="$(df -hPl /      | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"
    _hfs="$(df -hPl /home/ | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"
    echo "<span color=${_col}>${_icr}</span> ${_rfs} <span color=${_col}>${_ich}</span> ${_hfs}" | sed 's|&|&amp;|g'
}

ethernet () {
    _col="${col_cya}"
    _int='etherne'
    _ico=""
    _ic1=""
    _ic2=""
    _sto="/tmp/i3blocks-${_int}"

    get_text() {
        [[ "$(cat /sys/class/net/${_int}/operstate)" = 'down' ]] && exit

        _ipa="$(/usr/bin/ip -o -4 addr list ${_int} | awk '{print $4}' | cut -d/ -f1)"

        # grabbing data for each adapter.
        read rx < "/sys/class/net/${_int}/statistics/rx_bytes"
        read tx < "/sys/class/net/${_int}/statistics/tx_bytes"

        # get time
        time=$(date +%s)

        # write current data if file does not exist. Do not exit, this will cause
        # problems if this file is sourced instead of executed as another process.
        if ! [[ -f "${_sto}" ]]; then
            echo "${time} ${rx} ${tx}" > "${_sto}"
            chmod 0666 "${_sto}"
            exit
        fi

        # read previous state and update data storage
        read old < "${_sto}"
        echo "${time} ${rx} ${tx}" > "${_sto}"

        # parse old data and calc time passed
        old=(${old//;/ })
        time_diff=$(( $time - ${old[0]} ))

        # calc bytes transferred, and their rate in byte/s
        rx_diff=$(( $rx - ${old[1]} ))
        tx_diff=$(( $tx - ${old[2]} ))
        rx_rate=$(( $rx_diff / $time_diff ))
        tx_rate=$(( $tx_diff / $time_diff ))

        # Download speed
        rx_kib=$(( $rx_rate >> 10 ))
        if hash bc 2>/dev/null && [[ "$rx_rate" -gt 1048576 ]]
        then
            _dnl="$(echo "scale=1; $rx_kib / 1024" | bc) MiB/s"
        else
            _dnl="${rx_kib} KiB/s"
        fi

        # Upload speed
        tx_kib=$(( $tx_rate >> 10 ))
        if hash bc 2>/dev/null && [[ "$tx_rate" -gt 1048576 ]]
        then
            _upl="$(echo "scale=1; $tx_kib / 1024" | bc) MiB/s"
        else
            _upl="${tx_kib} KiB/s"
        fi

        echo "<span color=${_col}>${_ico}</span> ${_ipa} <span color=${_col}>${_ic1}</span> ${_upl} <span color=${_col}>${_ic2}</span> ${_dnl}" | sed 's|&|&amp;|g'
    }
    
    get_loop () {
        [[ ! -d /sys/class/net/${_int} ]] && exit
        while : ; do
            get_text
            sleep 5
        done
    }

    get_loop

}

case $1 in
    battery) battery ;;
    brightness) brightness ;;
    calendar) calendar ;;
    cpu) cpu ;;
    day) day ;;
    disk) disk ;;
    ethernet) ethernet ;;
    *) echo 'Missing module'; return 1; ;;
esac
