#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh
# Get color
_col="${base09:-#dc9656}"
_mut="${base03:-#585858}"

get_text() {
    _def=$(pacmd list-sinks |
        grep 'active port: ' |
        sed 's/.*active port: <\(.*\)>$/\1/' |
        head -n $(pacmd list-sinks |
        grep index | grep -n '\*' |
        sed 's/\(.\).*/\1/') |
        tail -1)
    case "$_def" in
        *hdmi*)                     _ico="﴿" ;;
        *headset*|*a2dp*|*hifi*)    _ico="" ;;
        *headphones*)               _ico="" ;;
        *speaker*)                  _ico="蓼" ;;
        *network*)                  _ico="爵" ;;
        *analog*)                   _ico="" ;;
        *)                          _ico="" ;;
    esac
    _ico="%{F${_col}}${_ico}%{F-}"
    _val="$(pamixer --get-volume)"
    [[ $(pamixer --get-mute) = "true" ]] && _val="%{F${_mut}}${_val}%{F-}"
    echo "${_ico} ${_val}"
}

get_text
/usr/bin/pactl subscribe | while read -r line ; do
    echo $line | grep -q -e "sink" -e "'change' on server #" && get_text
done
