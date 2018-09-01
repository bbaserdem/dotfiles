#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_red}"

case $BLOCK_BUTTON in
	1) /usr/bin/pamixer --toggle-mute;; # Left: mute
	3) /usr/bin/pavucontrol & disown ;; # Right: pavucontrol
	4) /usr/bin/pamixer --increase 5 ;; # Scroll up: increase
	5) /usr/bin/pamixer --decrease 5 ;; # Scroll down: decrease
esac

_def=$(pacmd list-sinks | grep 'active port: ' | sed 's/.*active port: <\(.*\)>$/\1/' | head -n $(pacmd list-sinks | grep index | grep -n '\*' | sed 's/\(.\).*/\1/') | tail -1)

case "$_def" in
    *hdmi*)
        _ico="﴿" ;;
    *headset*|*a2dp*)
        _ico="" ;;
    *headphones*)
        _ico="" ;;
    *speaker*)
        _ico="蓼" ;;
    *network*)
        _ico="爵" ;;
    *)
    _   icon="" ;;
esac

_val="$(pamixer --get-volume)"

if [[ $(pamixer --get-mute) = "true" ]]
then
    _pre="婢"
    _val='<span color='"$_mute"'>'"$_val"'%</span>'
elif [ "$_val" -ge 50 ]
then
    _pre="墳"
    _val="$_val"'%'
elif [ "$_val" -ge 10 ]
then
    _pre="奔"
    _val="$_val"'%'
else
    _pre="奄"
    _val="$_val"'%'
fi

echo '<span color='"$_col"'>'"$_pre"'</span> '"$_val"'<span color='"$_col"'> '"$_ico"'</span>'
