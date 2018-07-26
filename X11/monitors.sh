#!/usr/bin/sh

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
        # If lid is open, screen monitor should be on
        /usr/bin/xrandr --output $LID --auto --primary
    else
        # If lid is closed, turn off the lid screen
        /usr/bin/xrandr --output $LID --off
    fi

    # Set up the rest
    for monitor in $MON
    do
        /usr/bin/xrandr --output $monitor --auto
    done

elif [[ $(hostname) == 'sbpworkstation' ]]
then
    # Monitors are static
    /usr/bin/xrandr --output DP-2 --primary
    /usr/bin/xrandr --output DVI-I-1 --left-of DP-2

elif [[ $(hostname) == 'sbpserver' ]]
then
    echo 'Not set up yet'
fi
