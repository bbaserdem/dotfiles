#!/bin/sh

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

# Refresh monitors
_mon=$(bspc query --monitors | wc --lines)
if [[ "$_mon" == 1 ]]; then
    bspc monitor --reset-desktops $ws1 $ws2 $ws3 $ws4 $ws5 $ws6 $ws7 $ws8 $ws9 $ws0
elif [[ "$_mon" == 2 ]]; then
    bspc monitor $(bspc query --monitors|awk NR==1) --reset-desktops $ws1 $ws2 $ws3 $ws4 $ws5
    bspc monitor $(bspc query --monitors|awk NR==2) --reset-desktops $ws6 $ws7 $ws8 $ws9 $ws0
elif [[ "$_mon" == 3 ]]; then
    bspc monitor $(bspc query --monitors|awk NR==1) --reset-desktops $ws1 $ws2 $ws3 $ws4
    bspc monitor $(bspc query --monitors|awk NR==2) --reset-desktops $ws5 $ws6 $ws7
    bspc monitor $(bspc query --monitors|awk NR==3) --reset-desktops $ws8 $ws9 $ws0
else
    I=1
    for monitor in $(bspc query --monitors); do
        bspc monitor $monitor -n "$I" -d $I
        let I++
    done
fi

# Monocles
bspc desktop $ws4 --layout monocle
bspc desktop $ws5 --layout monocle
bspc desktop $ws6 --layout monocle
bspc desktop $ws7 --layout monocle
