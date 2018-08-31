#!/usr/bin/sh

_col="'$(xgetres i3.orang)'"
_ico=""
_spe="$(sensors | grep fan1 | cut -d " " -f 9)"

if [ "$_spe" != "" ]; then
    _spe="$(echo "scale=1;$speed/1000" | bc -l )"
else
   exit
fi

echo "<span color=${_col}>${_ico}</span> ${_spe}"
