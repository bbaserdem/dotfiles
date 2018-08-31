#!/usr/bin/sh

_col="'$(xgetres i3.yllow)'"
_ico=""
_per="$(mpstat | awk '/all/ { printf("%.2f",100.0 - $13) }')"

echo "<span color=${_col}>${_ico}</span> ${_per}%"
