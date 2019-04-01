#!/bin/sh
# Script to exit bspwm

# Save light config
/usr/bin/light -I

# Kill bspwm
bspc quit
