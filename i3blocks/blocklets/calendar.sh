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
    *)      _col="${col_bro}"  ;;
esac

_ico=""
_len=52
_txt="$(khal list | head -n 1)"
[ "${#_txt}" -gt "${_len}" ] && _txt="${_txt:0:${_len}}…"
[ "${_txt}" = "No events" ]  && _txt="<span color=${_mute}>${_txt}</span>"
echo "<span color=${_col}>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g'
