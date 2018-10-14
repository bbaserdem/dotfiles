#!/usr/bin/bash

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

_ico="力"
_val="$(free -m | grep Swap | awk '{ printf( $3 ) }' | numfmt --to=iec-i --suffix=B)"

echo "<span color=${_col}>${_ico}</span> ${_val}" | sed 's|&|&amp;|g'
