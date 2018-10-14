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
_fil="/tmp/i3block-cpu"

# Write and quit if doesn't exist
[ ! -e "${_fil}" ] || ( grep 'cpu ' /proc/stat > "${_fil}" && exit )
# Get CPU percentage from last time if exists
_per="$( echo "$(cat $_fil) $(grep 'cpu ' /proc/stat)" | awk '{ printf( "%.2f", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)) }' )"
# Write stuff
grep 'cpu ' /proc/stat > "${_fil}"

echo "<span color=${_col}>${_ico}</span> ${_per}%" | sed 's|&|&amp;|g'
