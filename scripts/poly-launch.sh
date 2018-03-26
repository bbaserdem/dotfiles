#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Load environmont variables file
source $XDG_CONFIG_HOME/polybar/env

case "$1" in
    --quit)
        echo ""
        ;;
    *)
        if [[ $(hostname) == 'sbpworkstation' ]]
        then
            nohup polybar wtop >/dev/null 2>&1 &
            nohup polybar wbot >/dev/null 2>&1 &
        else
            nohup polybar htop >/dev/null 2>&1 &
            nohup polybar hbot >/dev/null 2>&1 &
        fi
        ;;
esac
