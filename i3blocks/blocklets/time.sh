#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_cya}"
echo "<span color=${_col}></span> $(date '+%H:%M:%S')" | sed 's|&|&amp;|g'
