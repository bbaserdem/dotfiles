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

case $1 in
    battery) battery ;;
    brightness) brightness ;;
    *) echo 'Missing module'; return 1; ;;
esac
