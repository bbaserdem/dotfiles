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
    *)      _col="${col_gre}" ;;
esac

_col="${col_gre}"
_ico=""
_prc="$(free -m | grep Mem | awk '{ printf("%.1f", $3/$2 * 100.0) }')"
_val="$(free -m | grep Mem | awk '{ printf("%.2fGB",($3*1.0)/(1024.0)) }' )"

echo "<span color=${_col}>${_ico}</span> ${_val} (${_prc}%)" | sed 's|&|&amp;|g'
