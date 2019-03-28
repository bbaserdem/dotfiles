#!/bin/sh

# Get color
_col="${base0C:-#86c1b9}"
_mute="${base03:-#585858}"
_form="${1:-polybar}"

get_text() {
    _sink="$(pactl info | sed -n 's|Default Sink: \(.*\)|\1|p')"
    _line="$(pactl list sinks short | grep -n "${_sink}" | cut -d : -f 1)"
    _defn="$(pactl list sinks | sed -n 's|.*Active Port: \([^\s]*\).*|\1|p'"${_line}")"
    _volm="$(pactl list sinks | sed -n 's|^\sVolume: \(.*\)$|\1|p'"${_line}" | awk '
        BEGIN{ RS=" "; vol=0; n=0; }
        /[0-9]+%$/ { n++; vol+=$1; }
        END{ if(n>0) { printf( "%.0f", vol/n ); } }' )"

    case "$_defn" in
        *hdmi*)                     _ico="﴿" ;;
        *headset*|*a2dp*|*hifi*)    _ico="" ;;
        *headphones*)               _ico="" ;;
        *speaker*)                  _ico="蓼" ;;
        *network*)                  _ico="爵" ;;
        *analog*)                   _ico="" ;;
        *)                          _ico="" ;;
    esac

    case $_form in
        pango)      [[ $(pamixer --get-mute) = "true" ]] &&
            _volm="<span color=${_mute}>${_volm}</span>"
            echo "<span color=${_col}>${_ico}</span> ${_volm}"
            ;;
        polybar)    [[ $(pamixer --get-mute) = "true" ]] &&
            _volm="%{F${_mut}}${_volm}%{F-}"
            echo "%{F${_col}}${_ico}%{F-} ${_volm}"
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
