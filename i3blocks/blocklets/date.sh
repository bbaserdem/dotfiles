#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh
# Get color
_col="${1}"
case "$_col" in
    red)    _col="${col_red}" ;;
    orange) _col="${col_ora}" ;;
    yellow) _col="${col_yel}" ;;
    green)  _col="${col_gre}" ;;
    cyan)   _col="${col_cya}" ;;
    indigo) _col="${col_ind}" ;;
    violet) _col="${col_vio}" ;;
    brown)  _col="${col_bro}" ;;
    *)      _col="${col_ind}" ;;
esac

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

echo "$(get_lunar) $(date '+%a %d, %b %Y')" | sed 's|&|&amp;|g'
