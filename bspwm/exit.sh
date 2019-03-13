#!/bin/sh
# Script to exit bspwm

# Kill slideshow
${HOME}/.config/bspwm/wallpaper.sh -k

# Save light config
/usr/bin/light -I

# Kill bspwm
bspc quit
