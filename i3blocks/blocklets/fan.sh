#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_ora}"
_ico=""
_spe="$(sensors | grep fan1 | cut -d " " -f 9)"

if [ "$_spe" != "" ]; then
    _spe="$(echo "scale=1;$speed/1000" | bc -l )"
else
   exit
fi

echo "<span color=${_col}>${_ico}</span> ${_spe}" | sed 's|&|&amp;|g'
