#!/bin/sh

sink=$(( $(pacmd list-sinks | grep "active port" | sed -n '\|analog-output|=')-1 ))

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
    if [ "$(pamixer --sink $sink --get-mute)" = true ]; then
        PAIC=""
        volume="%{F${PB_MUTE}}--%{F-}"
    else
        volume="$(pamixer --sink $sink --get-volume)"
        if [ "$volume" -lt 30 ]; then
            PAIC=""
        else
            PAIC=""
        fi
        volume="${volume}%"
    fi

    if [ "$(pacmd list-sinks | grep "active port" | grep "analog" | sed 's/.*analog-output-\(.*\)>/\1/g')" == "headphones" ]
    then
        PAIC=""
    fi
    echo "%{F${PB_CRMS}}${PAIC}%{F-} $volume"
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

