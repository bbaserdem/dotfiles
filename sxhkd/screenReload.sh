#!/bin/sh
# Script to reload screen

# Run xrandr to fix screen
systemctl --user restart xrandr@${DISPLAY}.service
# Reconfigure bspwm
~/.config/bspwm/desktops
# Reload wallpaper
systemctl --user restart xrandr@${DISPLAY}.service
# Reload polybar
systemctl --user restart polybar-top@${DISPLAY}.service
systemctl --user restart polybar-bottom@${DISPLAY}.service
