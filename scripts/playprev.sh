#!/usr/bin/sh
_time="$(mpc status|grep playing|awk '{ sub(/\/.+/,"",$3); split($3,a,/:/); print a[1]*60+a[2] }')"

if [[ "${_time}" -ge 3 ]] ; then
    mpc seek 0
else
    mpc prev
fi
