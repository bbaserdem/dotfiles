#!/bin/dash

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

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

# Set remote as monocles
bspc desktop $ws5 --layout monocle
