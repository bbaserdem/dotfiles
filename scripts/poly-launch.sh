#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Load environmont variables file
source $XDG_CONFIG_HOME/polybar/env

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

case "$1" in
    --quit)
        echo ""
        ;;
    *)
        if [[ $(hostname) == 'sbpworkstation' ]]
        then
            polybar wtop &
            polybar wbot &
        else
            polybar htop &
            polybar hbot &
        fi
        ;;
esac
