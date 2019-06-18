#!/bin/sh

#############################################################################
# _______   __       _______..______    __          ___   ____    ____      #
#|       \ |  |     /       ||   _  \  |  |        /   \  \   \  /   /      #
#|  .--.  ||  |    |   (----`|  |_)  | |  |       /  ^  \  \   \/   /       #
#|  |  |  ||  |     \   \    |   ___/  |  |      /  /_\  \  \_    _/        #
#|  '--'  ||  | .----)   |   |  |      |  `----./  _____  \   |  |          #
#|_______/ |__| |_______/    | _|      |_______/__/     \__\  |__|          #
#                                                                           #
#     _______.  ______ .______       __  .______   .___________.    _______.#
#    /       | /      ||   _  \     |  | |   _  \  |           |   /       |#
#   |   (----`|  ,----'|  |_)  |    |  | |  |_)  | `---|  |----`  |   (----`#
#    \   \    |  |     |      /     |  | |   ___/      |  |        \   \    #
#.----)   |   |  `----.|  |\  \----.|  | |  |          |  |    .----)   |   #
#|_______/     \______|| _| `._____||__| | _|          |__|    |_______/    #
#############################################################################

# Default colorset; if colors not in ENV, default to base16-default
_mute="${base03:-#585858}"
col_frg="${base04:-#b8b8b8}"
col_bkg="${base01:-#282828}"
col_red="${base08:-#ab4642}"
col_ora="${base09:-#dc9656}"
col_yel="${base0A:-#f7ca88}"
col_gre="${base0B:-#a1b56c}"
col_cya="${base0C:-#86c1b9}"
col_ind="${base0D:-#7cafc2}"
col_vio="${base0E:-#ba8baf}"
col_bro="${base0F:-#a16946}"

print_help () {
    echo -e "Usage: $0 [-f <pango|lemonbar>] [-c <color>] [-h] MODULE" 1>&2
    exit 1
}

# Default to pango
_format="pango"
_color="${color}"
# Get options
while getopts ":f:c:h" _optns; do
    case "${_optns}" in
        f) _format="${OPTARG}" ;;
        c) _color="${OPTARG}"  ;;
        h) print_help ;;
    esac
done

if [ -z "$name" ] ; then
    _module=${@:$OPTIND:1}
else
    _module="${name}"
fi

# Check format
case $_format in
    pango|i3|i3blocks|sway|lemonbar|polybar|bspwm) ;;
    *) echo 'Invalid format'; exit 2 ;;
esac

# Check color
case $_color in
    0|8|red)                _color="${col_red}" ;;
    1|9|orange|ora)         _color="${col_ora}" ;;
    2|A|yellow|yel)         _color="${col_yel}" ;;
    3|B|green|gre)          _color="${col_gre}" ;;
    4|C|cyan|cya)           _color="${col_cya}" ;;
    5|D|blue|indigo|ind)    _color="${col_ind}" ;;
    6|E|pink|violet|vio)    _color="${col_vio}" ;;
    7|F|brown|bro)          _color="${col_bro}" ;;
esac

module_selection () {
    case $_module in
        battery) battery ;;
        brightness) brightness ;;   # Switch this to acpi?
        calendar) calendar ;;       # Right now, it's an infinite loop!
        cpu) cpu ;;
        day) day ;;
        clock) clock ;;
        disk) disk ;;
        ethernet) ethernet ;;
        wireless) wireless ;;
        internet) internet ;;
        fan) fan ;;
        email) email ;;
        kernel) kernel ;;
        keymap ) keymap ;;
        memory) memory ;;
        swap) swap ;;
        mpd) mpd ;;
        pulseaudio) pulseaudio ;; # Needs rewrite
        rss) rss ;;
        temperature) temperature ;;
        todo) todo ;;           # Not working?
        uptime) uptime ;;       # Not working?
        *) echo "Missing module ${_module}"; exit 3 ;;
    esac
}

json_output () {
    _icon="${1:0:30}"
    [ -z $2 ] && _urg="false" || _urg="true"
    echo "{
        \"full_text\":\"${1}\",
        \"short_text\":\"${_icon}\",
        \"color\":\"${col_frg}\",
        \"background\":\"${col_bkg}\",
        \"border\":\"${_mute}\",
        \"urgent\":${_urg},
        \"seperator\":true,
        \"separator_block_width\":1,
        \"markup\":\"pango\"
    }"
}

##########################################
#  __  __           _       _            #
# |  \/  | ___   __| |_   _| | ___  ___  #
# | |\/| |/ _ \ / _` | | | | |/ _ \/ __| #
# | |  | | (_) | (_| | |_| | |  __/\__ \ #
# |_|  |_|\___/ \__,_|\__,_|_|\___||___/ #
#                                        #
##########################################

# Display battery status
#   This module ignores colors
battery () {
    _cap="/sys/class/power_supply/BAT0/capacity"
    _stt="/sys/class/power_supply/BAT0/status"
    _onl="/sys/class/power_supply/AC0/online"
    
    get_text () {
        if [ -e "${_cap}" ] ; then 
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
        
            case $_format in
                pango|i3|i3blocks|sway)
                    json_output "<span color='${_col}'>${_ico}</span> ${_num}" ;;
                lemonbar|polybar|bspwm)
                    echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_num}%{-u}%{u-}"
            esac
        else
            echo ''
        fi
    }

    get_loop () {
        while : ; do
            sleep .2
            get_text
            inotifywait --timeout -1 "${_cap}" "${_stt}" "${_onl}" > /dev/null 2>&1 || break
        done
    }

    get_loop
}

# Display screen brightness
#   Needs the app light
brightness () {
    _file="/sys/class/backlight/${BRI_SCR}/brightness"
    _col="${_color:-$col_vio}"

    get_text () {
        if [ -e "${_file}" ] ; then
            _val="$(light | sed 's|^\(.*\)\..*|\1|')" || exit

            if   [ "$_val" -ge 75 ] ; then
                _ico=""
            elif [ "$_val" -ge 50 ] ; then
                _ico=""
            else
                _ico=""
            fi
        
            if [ ! -z "${_val}" ] ; then
                case $_format in
                    pango|i3|i3blocks|sway)
                        json_output "<span color='${_col}'>${_ico}</span> ${_val}" ;;
                    lemonbar|polybar|bspwm)
                        echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_val}%{-u}%{u-}"
                esac
            fi
        else
            echo ''
        fi
    }
    
    get_loop () {
        while : ; do
            get_text
            sleep .5
            inotifywait --timeout -1 "${_file}" > /dev/null 2>&1 || break
        done
    }

    get_action () {
        case $1 in
            4) /usr/bin/light -A 5 > /dev/null 2>&1 ;;
            5) /usr/bin/light -U 5 > /dev/null 2>&1 ;;
        esac
    }
    
    get_loop & while read button ; do get_action $button ; done
}

# Reads a khal calendar, and spits out the most urgent event
calendar () {
    _file="${HOME}/Documents/Calendar"
    _col="${_color:-$col_bro}"
    _ico=""
    _len=52

    get_text () {
        _txt="$(khal list | head -n 1)"
        [ "${#_txt}" -gt "${_len}" ] && _txt="${_txt:0:${_len}}…"
        case $_format in
            pango|i3|i3blocks|sway)
                [ "${_txt}" = "No events" ]  &&
                    _txt="<span color='${_mute}'>${_txt}</span>"
                    json_output "$(echo "<span color='${_col}'>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g')"
                ;;
            lemonbar|polybar|bspwm)
                [ "${_txt}" = "No events" ]  &&
                    _txt="%{F${_mute}}${_txt}%{F-}"
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}"
                ;;
        esac
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

# Calculate CPU percentage
#   Does not have seperate modules, cause I want to retain the info
cpu () {
    _col="${_color:-$col_yel}"
    _ico=""
    _cpu1="$(grep 'cpu ' /proc/stat)"

    while : ; do
        sleep 1
        _cpu2="$(grep 'cpu ' /proc/stat)"
        _per="$( echo "${_cpu1} ${_cpu2}" | awk '{ printf( "%.2f", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)) }' )"
        _cpu1="${_cpu2}"

        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_per}"
                ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_per}%{-u}%{u-}"
                ;;
        esac
    done
}

day () {
    _col="${_color:-$col_ind}"
    get_light () {
        case "$1" in
            0)  echo "" ;; 1)  echo "" ;; 2)  echo "" ;; 3)  echo "" ;;
            4)  echo "" ;; 5)  echo "" ;; 6)  echo "" ;; 7)  echo "" ;;
            8)  echo "" ;; 9)  echo "" ;; 10) echo "" ;; 11) echo "" ;;
            12) echo "" ;; 13) echo "" ;; 14) echo "" ;; 15) echo "" ;;
            16) echo "" ;; 18) echo "" ;; 19) echo "" ;; 20) echo "" ;;
            21) echo "" ;; 22) echo "" ;; 23) echo "" ;; 24) echo "" ;;
            25) echo "" ;; 26) echo "" ;; 27) echo "" ;; 28) echo "" ;;
            29) echo "" ;; 30) echo "" ;;
        esac
    }

    get_dark () {
        case "$1" in
            0)  echo "" ;; 1)  echo "" ;; 2)  echo "" ;; 3)  echo "" ;;
            4)  echo "" ;; 5)  echo "" ;; 6)  echo "" ;; 7)  echo "" ;;
            8)  echo "" ;; 9)  echo "" ;; 10) echo "" ;; 11) echo "" ;;
            12) echo "" ;; 13) echo "" ;; 14) echo "" ;; 15) echo "" ;;
            16) echo "" ;; 18) echo "" ;; 19) echo "" ;; 20) echo "" ;;
            21) echo "" ;; 22) echo "" ;; 23) echo "" ;; 24) echo "" ;;
            25) echo "" ;; 26) echo "" ;; 27) echo "" ;; 28) echo "" ;;
            29) echo "" ;; 30) echo "" ;;
        esac
    }

    get_text () {
        _ico="$(get_dark "$( echo "$(printf "%.0f" "$(echo "scale=2; ( $(date -d "00:00" +%s) - $(date -d "1999-08-11" +%s) )/(60*60*24)" | bc)") % 29.530588853" | bc | awk '{printf("%d",$1+.5)}' )")"
        _txt="$(date '+%a %d, %b %Y')"
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}"
                ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}"
                ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep "$(( $(date -d "tomorrow 0" +%s) - $(date +%s) + 5 ))"
        done
    }

    get_loop
}

clock () {
    _col="${_color:-$col_cya}"
    _ico=""

    get_text () {
        _txt="$(date '+%H:%M:%S')"
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}"
                ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}"
                ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 1
        done
    }

    get_loop
}

disk () {
    _col="${_color:-$col_bro}"
    _icr=""
    _ich=""

    get_text () {
        _rfs="$(df -hPl /      | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"
        _hfs="$(df -hPl /home/ | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_icr}</span> ${_rfs} <span color='${_col}'>${_ich}</span> ${_hfs}"
                ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_icr}%{F-} ${_rfs} %{F${_col}}${_ich}%{F-} ${_hfs}%{-u}%{u-}"
                ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 60
        done
    }

    get_loop
    
}

ethernet () {
    _col="${_color:-$col_cya}"
    _int='ethernet'
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

        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_ipa} <span color='${_col}'>${_ic1}</span> ${_upl} <span color='${_col}'>${_ic2}</span> ${_dnl}"
                ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_ipa} %{F${_col}}${_ic1}%{F-} ${_upl} %{F${_col}}${_ic2}%{F-} ${_dnl}%{-u}%{u-}"
                ;;
        esac
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

wireless () {
    _col="${_color:-$col_cya}"
    _int='wifi'
    _ico=""
    _ics="說"
    _ic1=""
    _ic2=""
    _sto="/tmp/i3blocks-${_int}"

    get_text() {
        # Exit if interface is not wireless
        [ ! -d "/sys/class/net/${_int}/wireless" ] && exit
        # Exit if interface is down
        [[ "$(cat /sys/class/net/${_int}/operstate)" = 'down' ]] && exit

        _sid="$(iwgetid | sed 's|.*ESSID:"\(.*\)"|\1|')"
        _sgn="$(grep ${_int} /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')"
        _ipa="$(/usr/bin/ip -o -4 addr list ${_int}|awk '{print $4}'|head -n1|cut -d/ -f1)"

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

        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_sid} <span color='${_col}'>${_ics}</span> ${_sgn}% <span color='${_col}'>${_ic1}</span> ${_upl} <span color='${_col}'>${_ic2}</span> ${_dnl}" | sed 's|&|&amp;|g' ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_sid} %{F${_col}}${_ics}%{F-} ${_sgn}% %{F${_col}}${_ic1}%{F-} ${_upl} %{F${_col}}${_ic2}%{F-} ${_dnl}%{-u}%{u-}" ;;
        esac
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

internet () {
    _col="${_color:-$col_cya}"
    _eint='ethernet'
    _eico=""
    _wint='wifi'
    _wico=""
    _uint='usbtether'
    _uico=""
    _bint="broadcast"
    _bico=""
    _ovpn=""
    _ocnc="ﮂ"

    _esta="/sys/class/net/${_eint}/operstate"
    _wsta="/sys/class/net/${_wint}/operstate"
    _usta="/sys/class/net/${_uint}/operstate"
    _bsta="/sys/class/net/${_bint}/operstate"

    get_text() {
        _txt=""
        [ -f ${_esta} ] && _econ="$(cat "${_esta}")"
        [ -f ${_wsta} ] && _wcon="$(cat "${_wsta}")"
        [ -f ${_usta} ] && _ucon="$(cat "${_usta}")"
        [ -f ${_bsta} ] && _bcon="$(cat "${_bsta}")"
        [[ ${_econ} == 'up' ]] && _txt="${_txt}${_eico} "
        [[ ${_wcon} == 'up' ]] && _txt="${_txt}${_wico} "
        [[ ${_ucon} == 'up' ]] && _txt="${_txt}${_uico} "
        [[ ${_bcon} == 'up' ]] && _txt="${_txt}${_bico} "
        pgrep openvpn     >/dev/null && _txt="${_txt}${_ovpn} "
        pgrep openconnect >/dev/null && _txt="${_txt}${_ocnc} "
        _txt="${_txt::-1}"

        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_txt}</span>" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_txt}%{F-}%{-u}%{u-}" ;;
        esac
    }
    
    get_loop () {
        while : ; do
            get_text
            sleep 5
        done
    }

    get_loop

}

fan () {
    _ico=""
    _col="${_color:-$col_ora}"

    get_text () {
        if [ $(hostname) = 'sbplaptop' ] ; then
            # Can't read this
            exit
        elif [ $(hostname) = 'sbpnotebook' ] ; then
            _spe="$(sensors | grep -i 'fan' | awk '{print $2}' | tr '\n' ',')"
            _spe="${_spe::-1}"
        else
            _spe="$(sensors | grep -i 'fan' | awk '{print $3}' | tr '\n' ',')"
            _spe="${_spe::-1}"
        fi

        [ ! -z "$_spe" ] && exit
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_spe}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_spe}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 5
        done
    }
    
    get_loop
}

email () {
    _col="${_color:-$col_yel}"
    _file="${HOME}/Documents/Mail/Gmail/Inbox/new"

    get_text () {
        _new="$(find $HOME/Documents/Mail/Gmail/Inbox/new | wc -l)"
        if [ "$_new" -le 0 ] ; then
            _ico=""
            _new=""
        else
            _ico=""
            _new=" ${_new}"
        fi
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span>${_new}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-}${_new}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 5
            inotifywait --timeout -1 --recursive "${_file}" > /dev/null 2>&1 || break
        done
    }

    get_loop
}

kernel () {
    _col="${_color:-$col_vio}"
    _dis="$(hostnamectl | sed -n 's/.*Operating System: \(.*\)/\1/p')"
    _txt="$(uname -r)"

    get_text () {
        case "$_dis" in
            "Arch Linux")   _ico="" ;;
            "Gentoo")       _ico="" ;;
        esac
    
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_text
}

keymap () {
    _col="${_color:-$col_vio}"
    _ico=""
    
    get_text () {
        _sta="$(xkb-switch -p)"
        _lan="$(echo "${_sta}" | sed 's|\(.*\)(.*)|\1|' | awk '{print toupper($0)}')"
        _lay="$(echo "${_sta}" | grep '(' | sed 's|.*(\(.*\))|\1|')"
        [ -z "${_lay}" ] && _lay="qwe" || _lay="${_lay:0:3}"
        _txt="${_lan}(${_lay})"

        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }
    
    get_loop () {
        get_text
        /usr/bin/xkb-switch -W | while IFS= read -r line ; do
            get_text
            sleep .1
        done
    }

    get_loop

}

memory () {
    _col="${_color:-$col_gre}"
    _ico=""

    get_text () {
        _prc="$(free -m | grep Mem | awk '{ printf("%.1f", $3/$2 * 100.0) }')"
        _val="$(free -m | grep Mem | awk '{ printf("%.2fGB",($3*1.0)/(1024.0)) }' )"
        _txt="${_val} (${_prc})"
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 1
        done
    }

    get_loop
}

swap () {
    _col="${_color:-$col_gre}"
    _ico="力"

    get_text () {
        _txt="$(free -m | grep Swap | awk '{ printf( $3 ) }' | numfmt --to=iec-i --suffix=B)"
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 1
        done
    }

    get_loop

}

mpd () {
    _col="${_color:-$col_red}"
    _len=32
    _ico=""
    _ilf=""
    
    get_text () {
        # Prompt stuff
        _dim=''
        _text="$(mpc $_pass status | head -n 1)"
        [ "${#_text}" -gt "${_len}" ] && _text="${_text:0:${_len}}…"
        _pre="$(mpc $_pass status | tail -n 2 | head -n 1 | awk '{print $1}')"
        if [ "${_text}" == "" ] ; then
            _txt="--"
            _dim='yes'
        elif [ "${_pre}" == "[paused]" ] ; then
            _dim='yes'
        elif [[ $_pre == volume:* ]] ; then
            _txt='Empty playlist…'
            _dim='yes'
        elif [ "${_pre}" == "Updating" ] ; then
            _txt='DB Update…</span>'
            _dim='yes'
        fi
        
        case $_format in
            pango|i3|i3blocks|sway)
                [ -z "${_dim}" ]                || _txt="<span color='${_mute}'>${_txt}</span>"
                pgrep mpdscribble >/dev/null    && _txt="${_txt} <span color='${_col}'>${_ilf}</span>"
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" ;;
            lemonbar|polybar|bspwm)
                [ -z "${_dim}" ]                || _txt="%{F${_mute}}${_txt}%{F-}"
                pgrep mpdscribble >/dev/null    && _txt="${_txt} %{F${_col}}${_ilf}%{F-}"
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep .2
            mpc idle > /dev/null || sleep 10
        done
    }

    get_action () {
        case $1 in
            1) mpc toggle > /dev/null ;;  # left click, toggle
            4) mpc prev > /dev/null ;;    # scroll up, previous
            5) mpc next > /dev/null ;;    # scroll down, next
        esac

    }

    get_loop &
    while read button ; do get_action $button ; done

}

# Pulseaudio daemon
#   Fully production ready
pulseaudio () {
    # Fix this to use only pacmd and pactl
    _col="${_color:-$col_red}"

    get_text() {
        _sink="$(pactl info | sed -n 's|Default Sink: \(.*\)|\1|p')"
        _line="$(pactl list sinks short | grep -n "${_sink}" | cut -d : -f 1)"
        _defn="$(pactl list sinks | sed -n 's|^\sActive Port: \([^\s]*\)|\1|p' | sed -n "${_line}p")"
        _ismt="$(pactl list sinks | sed -n 's|^\sMute: \([^\s]*\)|\1|p' | sed -n "${_line}p")"
        _volm="$(pactl list sinks | sed -n 's|^\sVolume: \(.*\)$|\1|p' | sed -n "${_line}p" | awk '
            BEGIN{ RS=" "; vol=0; n=0; }
            /[0-9]+%$/ { n++; vol+=$1; }
            END{ if(n>0) { printf( "%.0f", vol/n ); } }' )"

        case "$_defn" in
            *hdmi*)                     _icon="﴿" ;;
            *headset*|*a2dp*|*hifi*)    _icon="" ;;
            *headphones*)               _icon="" ;;
            *speaker*)                  _icon="蓼" ;;
            *network*)                  _icon="爵" ;;
            *analog*)                   _icon="" ;;
            *)                          _icon="" ;;
        esac

        if echo $_sink | grep -q 'bluez' ; then
            _icon=""
        fi

        case $_format in
            pango|i3|i3blocks|sway) [[ $_ismt = "yes" ]] &&
                _volm="<span color='${_mute}'>${_volm}</span>"
                json_output "<span color='${_col}'>${_icon}</span> ${_volm}" ;;
            lemonbar|polybar|bspwm) [[ $_ismt = "yes" ]] &&
                _volm="%{F${_mute}}${_volm}%{F-}"
                echo "%{u${_col} +u}%{F${_col}}${_icon}%{F-} ${_volm}%{-u u-}" ;;
        esac

    }

    get_loop() {
        get_text
        /usr/bin/pactl subscribe | while read -r line ; do
            echo $line |
                grep -q -e "sink" -e "'change' on server #" && 
                get_text
        done
    }

    get_action () {
        _sink="$(pactl info | sed -n 's|Default Sink: \(.*\)|\1|p')"
        _line="$(pactl list sinks short | grep -n "${_sink}" | cut -d : -f 1)"
        _volm="$(pactl list sinks | sed -n 's|^\sVolume: \(.*\)$|\1|p'"${_line}" | awk '
            BEGIN{ RS=" "; vol=0; n=0; }
            /[0-9]+%$/ { n++; vol+=$1; }
            END{ if(n>0) { printf( "%.0f", vol/n ); } }' )"

        case $1 in
            1)  # Left
                /usr/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null 2>&1
                ;;
            2) # Middle
                ;;
            3) # Right
                [ -x '/usr/bin/pavucontrol' ] && /usr/bin/pavucontrol > /dev/null 2>&1 &
                disown ;;
            4) # Scroll Up
                if [ "$_volm" -ge 100 ] ; then
                    /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ 100%  > /dev/null 2>&1
                else
                    /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ +5% > /dev/null 2>&1
                fi ;;
            5) # Scroll Down
                /usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%  > /dev/null 2>&1
                ;;
        esac
    }

    get_loop & while read button ; do get_action $button ; done
}

rss () {
    _col="${_color:-$col_gre}"
    _ico=""
    _file="${HOME}/Documents/RSS"

    get_text () {
        _txt="$(newsboat -x print-unread | awk '{ print $1 }')"
        [ "${_txt}" == "Error:" ] && _txt="<span color='${_mute}'></span>"

        case $_format in
            pango|i3|i3blocks|sway)
                [ "${_txt}" == "Error:" ] && _txt="<span color='${_mute}'></span>"
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g' ;;
            lemonbar|polybar|bspwm)
                [ "${_txt}" == "Error:" ] && _txt="%{F${_mute}}%{F-}"
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 5
            inotifywait --timeout -1 --recursive "${_file}" > /dev/null 2>&1 || break
        done
    }

    get_loop
}

temperature () {
    _col="${_color:-$col_red}"
    _cel="糖"

    get_text () {
        if [ $(hostname) = 'sbplaptop' ] ; then
            _tmp="$(sensors | grep 'Tdie:'      | awk '{print $2}' | sed 's/+\(.*\)°C/\1/')"
        elif [ $(hostname) = 'sbpnotebook' ] ; then
            _tmp="$(sensors | grep 'Package id' | awk '{print $4}' | sed 's/+\(.*\)°C/\1/')"
        else
            return
        fi

        _txt="${_tmp}${_cel}"

        # Do integer check
        _sto="$(echo ${_tmp} | awk '{ printf( "%d", $1 ); }')"
        if [ "${_sto}" -gt 75 ] ; then
            _ico=""
        elif [ "${_sto}" -gt 65 ] ; then
            _ico=""
        elif [ "${_sto}" -gt 55 ] ; then
            _ico=""
        elif [ "${_sto}" -gt 45 ] ; then
            _ico=""
        else
            _ico=""
        fi

        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 1
        done
    }

    get_loop
}

todo () {
    # Does not work
    _col="${_color:-$col_bro}"
    _ico="省"
    _len=32
    _file="${HOME}/Documents/Todo"

    get_text () {
        _txt="$(todo --porcelain list --sort priority | jq -r '.[0]."summary"')"

        case $_format in
            pango|i3|i3blocks|sway)
                [ "${_txt}" = "null" ] && _txt="<span color='${_mute}'>No tasks</span>"
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g' ;;
            lemonbar|polybar|bspwm)
                [ "${_txt}" = "null" ] && _txt="%{F${_mute}}No tasks%{F-}"
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 5
            inotifywait --timeout -1 --recursive "${_file}" > /dev/null 2>&1 ||
                break
        done
    }

    get_loop
}

uptime () {
    _col="${_color:-$col_cya}"
    _ico="⏼"

    get_text () {
        _txt="$(uptime --pretty | sed 's/up //' | sed 's/\ years\?,/y/' | sed 's/\ weeks\?,/w/' | sed 's/\ days\?,/d/' | sed 's/\ hours\?,\?/h/' | sed 's/\ minutes\?/m/')"
        case $_format in
            pango|i3|i3blocks|sway)
                json_output "<span color='${_col}'>${_ico}</span> ${_txt}" ;;
            lemonbar|polybar|bspwm)
                echo "%{u${_col}}%{+u}%{F${_col}}${_ico}%{F-} ${_txt}%{-u}%{u-}" ;;
        esac
    }

    get_loop () {
        while : ; do
            get_text
            sleep 60
        done
    }

    get_loop
}

module_selection
