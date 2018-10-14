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
    *)      _col="${col_vio}" ;;
esac

_ico=""

_sta="$(xkb-switch -p)"
_lan="$(echo "${_sta}" | sed 's|\(.*\)(.*)|\1|' | awk '{print toupper($0)}')"
_lay="$(echo "${_sta}" | grep '(' | sed 's|.*(\(.*\))|\1|')"
[ -z "${_lay}" ] && _lay="qwe" || _lay="${_lay:0:3}"

echo "<span color=${_col}>${_ico}</span> ${_lan}(${_lay})" | sed 's|&|&amp;|g'
