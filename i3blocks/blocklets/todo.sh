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
    *)      _col="${col_bro}" ;;
esac

_ico="省"
_len=32
_jso="$(todo --porcelain list --sort priority)"
_txt="$(echo "${_jso}" | jq -r '.[0]."summary"')"
[ "${_txt}" = "null" ] && _txt="<span color=${_mute}>No tasks</span>"
echo "<span color=${_col}>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g'
