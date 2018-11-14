#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh
# Get color
_col="${1}"
case "$_col" in
    red)    _col="${col_red}" ;;
    orange) _col="${col_ora}" ;;
    yellow) _col="${col_yel}" ;;
    green)  _col="${col_gre}" ;;
    cyan)   _col="${col_cya}" ;;
    indigo) _col="${col_ind}" ;;
    violet) _col="${col_vio}" ;;
    brown)  _col="${col_bro}" ;;
    *)      _col="${col_red}" ;;
esac

_cel="糖"

if [ $(hostname) = 'sbplaptop' ]
then
    _tmp="$(sensors|grep 'Tdie:'|awk '{print $2}'|sed 's/+\(.*\)°C/\1/')"
elif [ $(hostname) = 'sbpnotebook' ]
then
    _tmp="$(sensors|grep 'Package id'|awk '{print $4}'|sed 's/+\(.*\)°C/\1/')"
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

echo "<span color=${_col}>${_ico}</span> ${_tmp}${_cel}" | sed 's|&|&amp;|g'
