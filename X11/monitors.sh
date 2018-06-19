#!/bin/sh
### Bash stuff
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'


if [[ $(hostname) == 'sbplaptop' ]]
then

    # Get monitor and screen
    MON=$(xrandr | grep " connected " | awk '{ print$1 }' | { grep -v "eDP" || true; } )
    LID=$(xrandr | grep " connected " | awk '{ print$1 }' | grep "eDP")

    # Get lid state 
    if [[ $(cat /proc/acpi/button/lid/LID/state | awk '{ print $NF }') == 'open' ]]
    then
        # If lid is open, then mirror all displays
        /usr/bin/xrandr --output $LID --mode 1920x1080 --primary
        for monitor in $MON
        do
            /usr/bin/xrandr --output $monitor --same-as $LID
        done
    else
        # If lid is closed, its a free for all
        /usr/bin/xrandr --output $LID --off
        for monitor in $MON
        do
            /usr/bin/xrandr --output $monitor
        done

    fi

elif [[ $(hostname) == 'sbpworkstation' ]]
then
    /usr/bin/xrandr --output DP-2 --primary
    /usr/bin/xrandr --output DVI-I-1 --left-of DP-2
fi
