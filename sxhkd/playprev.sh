#!/bin/sh
# This script rewinds or plays previous song

if [[ $(mpc status | awk '/^\[playing\]/ { sub(/\/.+/,"",$3); split($3,a,/:/); print a[1]*60+a[2] }') -ge 3 ]]
then
    mpc seek 0;
else
    mpc prev;
fi
