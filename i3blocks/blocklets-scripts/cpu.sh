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
    *)      _col="${col_yel}" ;;
esac

_ico=""
_cpu1="$(grep 'cpu ' /proc/stat)"

while : ; do
    sleep 1
    _cpu2="$(grep 'cpu ' /proc/stat)"
    _per="$( echo "${_cpu1} ${_cpu2}" | awk '{ printf( "%.2f", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)) }' )"
    _cpu1="${_cpu2}"
    echo "<span color=${_col}>${_ico}</span> ${_per}%" | sed 's|&|&amp;|g'
done
