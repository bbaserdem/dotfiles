#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_yel}"
_ico=""
_fil="/tmp/i3block-cpu"

# Write and quit if doesn't exist
[ ! -e "${_fil}" ] || ( grep 'cpu ' /proc/stat > "${_fil}" && exit )
# Get CPU percentage from last time if exists
_per="$( echo "$(cat $_fil) $(grep 'cpu ' /proc/stat)" | awk '{ printf( "%.2f", ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5)) }' )"
# Write stuff
grep 'cpu ' /proc/stat > "${_fil}"

echo "<span color=${_col}>${_ico}</span> ${_per}%" | sed 's|&|&amp;|g'
