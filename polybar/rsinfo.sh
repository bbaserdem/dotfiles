#!/bin/sh
case "$1" in
    --toggle)
        if [ "$(pgrep -x redshift)" ]; then
            pkill -f redshift
        else
            redshift &
        fi
        ;;
    *)
    if [ "$(pgrep -x redshift)" ]; then
        temp=$(redshift -p 2> /dev/null | grep temp | cut -d ":" -f 2 | tr -dc "[:digit:]")
        if [ -z "$temp" ]; then
            col="#65737E"
        elif [ "$temp" -ge 5000 ]; then
            col="#8FA1B3"
        elif [ "$temp" -ge 4000 ]; then
            col="#EBCB8B"
        else
            col="#D08770"
        fi
    else
        col="${PB_MUTE}"
    fi
    echo "%{F${col}}%{F-}"
    ;;
esac
