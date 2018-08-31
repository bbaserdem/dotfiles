#!/bin/sh

_col="'$(xgetres i3.indgo)'"
_ico="⏼"
_pro="$(uptime --pretty | sed 's/up //' | sed 's/\ years\?,/y/' | sed 's/\ weeks\?,/w/' | sed 's/\ days\?,/d/' | sed 's/\ hours\?,\?/h/' | sed 's/\ minutes\?/m/')"

echo "<span color=${_col}>${_ico}</span> ${_pro}"
