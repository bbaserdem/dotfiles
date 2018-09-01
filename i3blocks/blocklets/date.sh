#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_ind}"
echo "<span color=${_col}></span> $(date '+%a %d, %b %Y')"
