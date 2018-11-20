#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

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

text_loop () {
    while : ; do
        get_text
        sleep .2
        inotifywait --timeout -1 "${_cap}" "${_stt}" "${_onl}" > /dev/null 2>&1 || break
    done
}

text_loop
