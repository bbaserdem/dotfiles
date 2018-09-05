#!/usr/bin/sh

# Reloading monitors program, coded for each setup
reload_monitors () {

    # LAPTOP: has eDP-1 (lid) DP-1 and DP-2 ports
    if [[ $(hostname) == 'sbplaptop' ]]
    then
        # Get xrandr names of monitor and the embedded screen
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

    # WORKSTATION: Monitors are static
    elif [[ $(hostname) == 'sbpworkstation' ]]
    then
        /usr/bin/xrandr --output DP-2 --primary
        /usr/bin/xrandr --output DVI-I-1 --left-of DP-2

    # NOTEBOOK: should have eDP-1 (lid)
    elif [[ $(hostname) == 'sbpnotebook' ]]
    then
        # 4k should be disabled!
        echo 'Not set up yet' && exit

    elif [[ $(hostname) == 'sbpserver' ]]
    then
        # Server not configured
        echo 'Not set up yet' && exit
    fi
}

# Start by performing a monitor setup once
reload_monitors

# Get /proc files to watch with inotifywait
_displays=($(find /sys/class/drm/* -name 'card[0-9]-*' | sed 's|$|/status|'))
[ -z "${_displays}" ] && exit

# Set infinite loop
while :
do
    inotifywait $_displays
    sleep .1
    reload_monitors
done

