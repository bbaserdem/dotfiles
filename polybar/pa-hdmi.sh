#!/bin/sh

sink=$(( $(pacmd list-sinks | grep "active port" | sed -n '\|hdmi-output|=')-1 ))

volume_up() {
    if [[ $(pamixer --sink $sink --get-volume) -le 94 ]]; then
        pactl set-sink-volume $sink +5%
    else
        pactl set-sink-volume $sink 100%
    fi
}

volume_down() { 
    pactl set-sink-volume $sink -5%
}

volume_mute() { 
    pactl set-sink-mute $sink toggle 
}

volume_print() {
    if [ "$sink" == -1 ]; then
        echo ""
    else
        if [ "$(pamixer --sink $sink --get-mute)" == true ]; then
            volume="%{F${PB_MUTE}}--%{F-}"
        else
            volume="$(pamixer --sink $sink --get-volume)%"
        fi
        echo "%{F${PB_CRMS}}%{F-} $volume"
    fi
}

listen() {
    volume_print

    pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "#$sink"; then
            volume_print
        fi
    done
}

case "$1" in
    --up)
        volume_up
        ;;
    --dn)
        volume_down
        ;;
    --mt)
        volume_mute
        ;;
    *)
        listen
        ;;
esac

