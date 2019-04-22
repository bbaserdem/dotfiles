#!/bin/sh

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

reload_monitors () {
    # LAPTOP: has eDP(-1) (lid) DP-1 and DP-2 ports
    if [ $(hostname) = 'sbplaptop' ] || [ $(hostname) = 'sbpnotebook' ] ; then
        echo "Using Laptop"
        # Get xrandr names of monitor and the embedded screen
        _lid=($(xrandr | awk '$1 ~ /eDP/ {printf("%s\n",$1);}'))
        _mon=($(xrandr | awk '$2 ~ /^connected/ && $1 !~ /eDP/ {printf("%s\n",$1);}'))
        _dis=($(xrandr | awk '$2 ~ /disconnected/ {printf("%s\n",$1);}'))
        echo "Lid is: ${_lid}"
        echo "Connected are: ${_mon}"
        echo "Disconnected are: ${_dis}"

        # Get lid state 
        if [[ "$(cat /proc/acpi/button/lid/LID/state | awk '{ print $NF }')" == 'open' ]]
        then
            # If lid is open, screen monitor should be on
            /usr/bin/xrandr --output $_lid --auto --primary
            echo "Output on: $_lid"
            # Set up the rest to mirror
            for monitor in $_mon
            do
                echo "Mirror $monitor"
                /usr/bin/xrandr --output $monitor --auto --same-as $_lid
            done
        else
            # Set up the monitors sequentially
            for monitor in $_mon
            do
                echo "On auto $monitor"
                /usr/bin/xrandr --output $monitor --auto
            done
        fi

        # Kill unused monitors
        for monitor in $_dis
        do
            echo "Turn off $monitor"
            /usr/bin/xrandr --output $monitor --off
        done

    # WORKSTATION: Monitors are static
    elif [[ $(hostname) == 'sbpworkstation' ]]
    then
        echo "Using Workstation"
        /usr/bin/xrandr --output DVI-I-1 --primary
        /usr/bin/xrandr --output DP-2 --left-of DVI-I-1

    # SERVER: 
    elif [[ $(hostname) == 'sbpserver' ]]
    then
        echo "Using Server"
        /usr/bin/xrandr --output DP-1 --primary
        /usr/bin/xrandr --output HDMI-2 --left-of DP-2

    # For all other cases
    else
        echo "No match"
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
