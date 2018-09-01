#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_vio}"
_ico=""
echo "<span color=${_col}>${_ico}</span> $(uname -r)"
