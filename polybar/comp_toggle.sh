#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep -x compton)" ]; then
            pkill compton
        else
            compton -b
        fi
        ;;
    *)
        if [ "$(pgrep -x compton)" ]; then
            echo "%{F${PB_VIOL}}%{F-}"
        else
            echo "%{F${PB_MUTE}}%{F-}"
        fi
        ;;
esac
