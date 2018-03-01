#!/bin/sh
# Script to change wallpapers, with different options for office and home
if [[ $(hostname) == 'sbpworkstation' ]]
then
    # At office
    WALLP_L=`find $HOME/Pictures/Wallpapers/Dual/ -name '*[L]*.jpg' -print | shuf -n 1`
    WALLP_R="${WALLP_L/\[L\]/[R]}"
    feh --bg-scale $WALLP_L --bg-scale $WALLP_R
else
    # All other situations
    feh --randomize --bg-fill $HOME/Pictures/Wallpapers
fi
