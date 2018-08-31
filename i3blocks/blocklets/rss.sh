#!/usr/bin/sh
_col="'$(/usr/bin/xgetres i3.green)'"
_ico=""
_num="$(newsboat -x print-unread | awk '{ print $1 }')"
echo "<span color=${_col}>${_ico}</span> ${_num}"
