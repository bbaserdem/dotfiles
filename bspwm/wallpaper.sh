#!/bin/dash

# This script refreshes backdrop of desktops

# Get rectangle information of the screen
_rect="$(xdpyinfo | awk '/dimensions/ {print $2;}')"
_x="$(echo "${_rect}" | sed 's|\([0-9]*\)x\([0-9]*\)|\1|')"
_y="$(echo "${_rect}" | sed 's|\([0-9]*\)x\([0-9]*\)|\2|')"

# Default directory
_dir="${HOME}/Pictures/Wallpapers/"

# Set a theme (maybe to be modded later)
_theme=''

# Find a random wallpaper that is the current monitor size or above
_img="$(find "${_dir}" \
    -name "${_theme}*" \
    -exec identify -format "%w %h ${_dir}%f\n" {} \; |
    awk 'int($1) >= '"${_x}"' && int($2) >= '"${_y}"' {print $3}' |
    shuf -n 1 -)"

# Set without using Xinerama
feh --no-fehbg --bg-scale --no-xinerama "${_img}"
