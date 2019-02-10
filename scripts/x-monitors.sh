#!/usr/bin/sh

# Reloading monitors program, coded for each setup
reload_monitors () {

    # LAPTOP: has eDP-1 (lid) DP-1 and DP-2 ports
    if [ $(hostname) = 'sbplaptop' ] || [ $(hostname) = 'sbpnotebook' ]
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

    # SERVER: 
    elif [[ $(hostname) == 'sbpserver' ]]
    then
        /usr/bin/xrandr --output DP-1 --primary
        /usr/bin/xrandr --output HDMI-2 --left-of DP-2

    # For all other cases
    else
        for monitor in $(xrandr | grep " connected " | awk '{ print$1 }') ; do
            /usr/bin/xrandr --output $monitor --auto
        done
    fi
}

# Daemonized form
monitor_hotplug() {
    _displays=($(find /sys/class/drm/* -name 'card[0-9]-*' | sed 's|$|/status|'))
    [ -z "${_displays}" ] && ( reload_monitors ; exit )
    while : ; do
        reload_monitors
        sleep 1
        inotifywait --timeout -1 $_displays || break
    done
}

case $1 in
    --now)  reload_monitors ;;
    *)      monitor_hotplug ;;
esac
