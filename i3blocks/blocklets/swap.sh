#!/usr/bin/bash

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_gre}"
_ico="力"
_val="$(free -m | grep Swap | awk '{ printf( $3 ) }' | numfmt --to=iec-i --suffix=B)"

echo "<span color=${_col}>${_ico}</span> ${_val}"
