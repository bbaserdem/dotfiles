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
_img="$(find "${_dir}/${_x}x${_y}" -type f -name "${_theme}*" | shuf -n 1 -)"

# Save the background location, for quick setting in the future
mkdir -p "${XDG_CACHE_HOME}/bspwm"
ln -sf "${_img}" "${XDG_CACHE_HOME}/bspwm/last_wallpaper"

# Set without using Xinerama
feh --no-fehbg --bg-scale --no-xinerama "${_img}"
