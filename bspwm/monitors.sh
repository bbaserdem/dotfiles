#!/bin/sh

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

reload_monitors () {
    # LAPTOP: has eDP(-1) (lid) DP-1 and DP-2 ports
    if [ $(hostname) = 'sbplaptop' ] || [ $(hostname) = 'sbpnotebook' ]
    then
        # Get xrandr names of monitor and the embedded screen
        _mon=($(xrandr | awk '/connected/ && $1 !~ /eDP/ {printf("%s ",$1);}'))
        _lid=($(xrandr | awk '/connected/ && $1 ~ /eDP/ {printf("%s ",$1);}'))

        # Get lid state 
        if [[ "$(cat /proc/acpi/button/lid/LID/state | awk '{ print $NF }')" == 'open' ]]
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
        /usr/bin/xrandr --output DVI-I-1 --primary
        /usr/bin/xrandr --output DP-2 --left-of DVI-I-1

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

refresh_desktops () {
    # This script refreshes desktops
    _mon="$(bspc query --monitors | wc --lines)"
    case $_mon in
        1)  bspc monitor --reset-desktops $ws1 $ws2 $ws3 $ws4 $ws5 $ws6 $ws7 $ws8 $ws9 $ws0 ;;
        2)  bspc monitor $(bspc query --monitors|awk NR==1) --reset-desktops $ws1 $ws2 $ws3 $ws4 $ws5
            bspc monitor $(bspc query --monitors|awk NR==2) --reset-desktops $ws6 $ws7 $ws8 $ws9 $ws0 ;;
        3)  bspc monitor $(bspc query --monitors|awk NR==1) --reset-desktops $ws1 $ws2 $ws3 $ws4
            bspc monitor $(bspc query --monitors|awk NR==2) --reset-desktops $ws5 $ws6 $ws7
            bspc monitor $(bspc query --monitors|awk NR==3) --reset-desktops $ws8 $ws9 $ws0 ;;
        *)  i=1
            for monitor in $(bspc query --monitors); do
                bspc monitor $monitor -n "$i" -d $i
                let i++
            done ;;
    esac

}

# Daemonized form
monitor_hotplug() {
    # Hook to udevadm
    udevadm monitor --tag-match='monitor-change' | while read -r line ; do
        if echo $line | grep -q 'drm' ; then
            reload_monitors
            refresh_desktops
        fi
    done
}

print_help () {
    echo 'BSPWM hotplug listener'
    echo 'Usage: monitors.st [options]'
    echo '    --refresh:    Refresh the workspace layout'
    echo '    --oneshot:    Manually load xrandr'
    echo '    --daemon:     Listen to udevadm to reload on monitor events'
    echo '    --help:       Print this message'
}

case $1 in
    --refresh)  refresh_desktops ;;
    --oneshot)  reload_monitors ; refresh_desktops ;;
    --daemon)   monitor_hotplug ;;
    --help)     print_help ;;
    *)          echo 'Unknown command' ; print_help ; exit 2 ;;
esac
