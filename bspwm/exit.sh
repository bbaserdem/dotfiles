#!/bin/sh
# Script to exit bspwm

# Kill slideshow
${HOME}/.config/bspwm/wallpaper.sh -k

# Kill bspwm
bspc quit
