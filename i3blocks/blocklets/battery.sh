#!/usr/bin/sh

_num=`cat /sys/class/power_supply/BAT0/capacity` || exit
_sta=`cat /sys/class/power_supply/BAT0/status`
_acp=`cat /sys/class/power_supply/AC0/online`

if [ "$_num" -ge 80 ]
then
    # Green ()
    _col="'$(/usr/bin/xgetres i3.green)'"
    _ico=""
elif [ "$_num" -ge 60 ]
then
    # Yellow (0A)
	_col="'$(/usr/bin/xgetres i3.yllow)'"
    _ico=""
elif [ "$_num" -ge 40 ]
then
    # Orange (09)
	_col="'$(/usr/bin/xgetres i3.orang)'"
    _ico=""
elif [ "$_num" -ge 20 ]
then
    # Red (08)
	_col="'$(/usr/bin/xgetres i3.crmsn)'"
    _ico=""
else
    # White (03)
	_col="'$(/usr/bin/xgetres i3.foreg)'"
    _ico=""
fi


if [ "$_sta" = "Charging" ]
then
    _ico=${_ico:1:2}
elif [ "$_acp" = "1" ]
then
    _ico=""
else
    _ico=${_ico:0:1}
fi

echo "<span color=${_col}>${_ico}</span> ${_num}%"
