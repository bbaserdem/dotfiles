#!/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
LOC="${XDG_CONFIG_HOME}/polybar/config.ini"

case "$1" in
    --quit)
        echo ""
        ;;
    *)
        if [[ $(hostname) == 'sbpworkstation' ]]
        then
            nohup polybar -c $LOC wtop >/dev/null 2>&1 &
            nohup polybar -c $LOC wbot >/dev/null 2>&1 &
        else
            nohup polybar -c $LOC top >/dev/null 2>&1 &
            nohup polybar -c $LOC bot >/dev/null 2>&1 &
        fi
        ;;
esac
