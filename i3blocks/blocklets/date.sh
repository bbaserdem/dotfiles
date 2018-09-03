#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_ind}"

get_lunar () {
    _days=$(python -c 'from datetime import date as d;print((d.today()-d(1999,8,11)).days)')
    _moon="$(echo "${_days} % 29.530588853" | bc | awk '{printf("%d",$1+.5)}')"
    case "${_moon}" in
        0|30)   _ico="" ;;
        1)      _ico="" ;;
        2)      _ico="" ;;
        3)      _ico="" ;;
        4)      _ico="" ;;
        5)      _ico="" ;;
        6)      _ico="" ;;
        7)      _ico="" ;;
        8)      _ico="" ;;
        9)      _ico="" ;;
        10)     _ico="" ;;
        11)     _ico="" ;;
        12)     _ico="" ;;
        13)     _ico="" ;;
        14)     _ico="" ;;
        15)     _ico="" ;;
        16)     _ico="" ;;
        18)     _ico="" ;;
        19)     _ico="" ;;
        20)     _ico="" ;;
        21)     _ico="" ;;
        22)     _ico="" ;;
        23)     _ico="" ;;
        24)     _ico="" ;;
        25)     _ico="" ;;
        26)     _ico="" ;;
        27)     _ico="" ;;
        28)     _ico="" ;;
        29)     _ico="" ;;
        *)      _ico="" ;;
    esac
    echo "<span color=${_col}>${_ico}</span>"
}

echo "<span color=${_col}></span> $(date '+%a %d, %b %Y') $(get_lunar)"
