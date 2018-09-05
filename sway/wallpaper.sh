#!/usr/bin/sh
# Script to change wallpapers, with different options for office and home
if [[ $(hostname) == 'sbpworkstation' ]]
then
    # At office
    _wall_l="$(find "${HOME}/Pictures/Wallpapers/Dual/" -name '*[L]*.jpg' -print | shuf -n 1)"
    _wall_r="$(echo "${_wall_l}" | sed 's|\[L\]|\[R\]|g')"
    swaymsg output DVI-I-1 bg "${_wall_l}" fill
    swaymsg output DP-2    bg "${_wall_r}" fill
else
    # All other situations
    for _mon in $(swaymsg -t get-outputs)
    do
        _wall="$(find "${HOME}/Pictures/Wallpapers/Dual/" -maxdepth 1 -print | shuf -n 1)"
        swaymsg output "${_mon}" bg "${_wall}" fill
    done
fi
