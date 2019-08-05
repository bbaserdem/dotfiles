#!/bin/bash

killall polybar
for mon in $(xrandr --query | grep " connected" | cut -d " " -f1); do
    POLYMON=$mon polybar top & disown
done
