#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_red}"
_cel="糖"

if [ $(hostname) = 'sbplaptop' ]
then
    _tmp="$(sensors | grep 'Tdie:' | awk '{print $2}' | sed 's/+\(.*\)°C/\1/')"
else
    return
fi

# Do integer check
_sto="$(echo ${_tmp} | sed 's/\(.*\)\..*/\1/')"
if [ "${_sto}" -gt 75 ]
then
    _ico=""
elif [ "${_sto}" -gt 65 ]
then
    _ico=""
elif [ "${_sto}" -gt 55 ]
then
    _ico=""
elif [ "${_sto}" -gt 45 ]
then
    _ico=""
else
    _ico=""
fi

echo "<span color=${_col}>${_ico}</span> ${_tmp}${_cel}"
