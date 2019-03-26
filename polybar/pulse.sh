#!/bin/sh

# Get color
_col="${base0C:-#86c1b9}"
_mute="${base03:-#585858}"
_form="${1:-pango}"

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
    _val="$(pamixer --get-volume)"

    case $_form in
        pango)      [[ $(pamixer --get-mute) = "true" ]] &&
            _val="<span color=${_mute}>${_val}</span>"
            echo "<span color=${_col}>${_ico}</span> ${_val}"
            ;;
        polybar)    [[ $(pamixer --get-mute) = "true" ]] &&
            _val="%{F${_mut}}${_val}%{F-}"
            echo "%{F${_col}}${_ico}%{F-} ${_val}"
            ;;
    esac
}

get_loop () {
    get_text
    /usr/bin/pactl subscribe | while read -r line ; do
        echo $line | grep -q -e "sink" -e "'change' on server #" && get_text
    done
}

get_loop
