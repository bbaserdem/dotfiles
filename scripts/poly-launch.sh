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
            nohup polybar work_top </dev/null >/dev/null 2>&1 &
            nohup polybar work_bot </dev/null >/dev/null 2>&1 &
        else
            nohup polybar laptop_top </dev/null >/dev/null 2>&1 &
            nohup polybar laptop_bot </dev/null >/dev/null 2>&1 &
        fi
        ;;
esac
