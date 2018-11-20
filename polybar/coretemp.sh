#!/usr/bin/sh

_col="${base08:-#ab4642}"
_wrn="${base09:-#dc9656}"
_thr=80

tmp="$(sensors | grep Core | awk 'BEGIN {tot = 0 } { tot += substr($3,2,length($3)-5) } END{ printf( "%3.1f糖", tot/NR ) }')"
pre="$(echo "${tmp}" | awk '{printf("%.0f",$1)}')"

if [ "${pre}" -ge "${_wrn}" ] ; then
    ico="
    echo "%{F${_wrn}}${_
