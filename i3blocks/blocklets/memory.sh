#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_gre}"
_ico=""
_prc="$(free -m | grep Mem | awk '{ printf("%.1f", $3/$2 * 100.0) }')"
_val="$(free -m | grep Mem | awk '{ printf("%.2fGB",($3*1.0)/(1024.0)) }' )"

echo "<span color=${_col}>${_ico}</span> ${_val} (${_prc}%)" | sed 's|&|&amp;|g'
