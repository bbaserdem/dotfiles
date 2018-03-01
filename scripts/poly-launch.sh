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
            polybar -c $LOC wtop &
            polybar -c $LOC wbot &
        else
            polybar -c $LOC top &
            polybar -c $LOC bot &
        fi
        ;;
esac
