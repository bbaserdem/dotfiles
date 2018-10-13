#!/usr/bin/sh
# Script to change wallpapers, with different options for office and home
if [[ $(hostname) == 'sbpworkstation' ]]
then
    feh --no-fehbg --randomize --bg-scale --no-xinerama ~/Pictures/Wallpapers/Dual/
else
    # All other situations
    feh --no-fehbg --randomize --bg-fill ~/Pictures/Wallpapers
fi
