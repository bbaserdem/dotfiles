#!/bin/dash

# This script refreshes backdrop of desktops
_rect="$(xdpyinfo | awk '/dimensions/ {print $2;}')"
_mnum="$(bspc query --monitors | wc --lines)"

# Default directory
_dir="${HOME}/Pictures/Wallpapers/"

# Check if there are multiple monitors
if [ "${_mnum}" = '2' ]; then
    _rect="$(xdpyinfo | awk '/dimensions/ {print $2;}')"
    # Check if it is a rotated monitor layout or not
    if [ "${_rect}" = '3000x1920' ] ; then
        _dir="${HOME}/Pictures/Wallpapers/Dual_Mixed/"
    elif [ "${_rect}" = '2160x1920' ] ; then
        _dir="${HOME}/Pictures/Wallpapers/Dual_Vertical/"
    elif [ "${_rect}" = '1080x3840' ] ; then
        _dir="${HOME}/Pictures/Wallpapers/Dual_Horizontal/"
    fi
fi

# Set without using Xinerama
feh --no-fehbg --randomize --bg-scale --no-xinerama "${_dir}"
