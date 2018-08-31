#!/usr/bin/bash

_col="'$(xgetres i3.green)'"
_ico="力"
_val="$(free -m | grep Swap | awk '{ printf( $3 ) }' | numfmt --to=iec-i --suffix=B)"

echo "<span color=${_col}>${_ico}</span> ${_val}"
