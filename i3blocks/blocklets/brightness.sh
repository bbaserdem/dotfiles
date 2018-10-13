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
    *)      _col="${col_vio}" ;;
esac

_val="$(brightnessctl -d $BRI_SCR i | grep Current | sed 's|.*(\(.*\)%)|\1|')" || exit

if   [ "$_val" -ge 75 ]
then
	_icon=""
elif [ "$_val" -ge 50 ]
then
	_icon=""
else
	_icon=""
fi

case $BLOCK_BUTTON in
    4) /usr/bin/brightnessctl -d $BRI_SCR s +10 >/dev/null ;;
    5) /usr/bin/brightnessctl -d $BRI_SCR s 10- >/dev/null ;;
esac

[ -z "${_val}" ] || echo '<span color='"$_col"'>'"$_icon"'</span> '"$_val"'%' | sed 's|&|&amp;|g'
