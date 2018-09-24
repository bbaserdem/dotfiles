#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_vio}"
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

echo '<span color='"$_col"'>'"$_icon"'</span> '"$_val"'%' | sed 's|&|&amp;|g'
