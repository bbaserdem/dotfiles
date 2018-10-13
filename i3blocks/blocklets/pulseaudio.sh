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

case $BLOCK_BUTTON in
	1) /usr/bin/pamixer --toggle-mute;; # Left: mute
	3) /usr/bin/pavucontrol & disown ;; # Right: pavucontrol
	4) /usr/bin/pamixer --increase 5 ;; # Scroll up: increase
	5) /usr/bin/pamixer --decrease 5 ;; # Scroll down: decrease
esac

_def=$(pacmd list-sinks |
    grep 'active port: ' |
    sed 's/.*active port: <\(.*\)>$/\1/' |
    head -n $(pacmd list-sinks |
    grep index | grep -n '\*' |
    sed 's/\(.\).*/\1/') |
    tail -1)

case "$_def" in
    *hdmi*)             _ico="﴿" ;;
    *headset*|*a2dp*)   _ico="" ;;
    *headphones*)       _ico="" ;;
    *speaker*)          _ico="蓼" ;;
    *network*)          _ico="爵" ;;
    *analog*)           _ico="" ;;
    *)                  _ico="" ;;
esac

_val="$(pamixer --get-volume)%"
[[ $(pamixer --get-mute) = "true" ]] && _val="<span color=${_mute}>${_val}</span>"

echo "<span color=${_col}>${_ico}</span> ${_val}" | sed 's|&|&amp;|g'
