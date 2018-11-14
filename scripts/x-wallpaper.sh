#!/usr/bin/sh
# Script to change wallpapers, with different options for office and home

change_wallpapers() {
    if [[ $(hostname) == 'sbpworkstation' ]]
    then
        feh --no-fehbg --randomize --bg-scale --no-xinerama ~/Pictures/Wallpapers/Dual/
    else
        # All other situations
        feh --no-fehbg --randomize --bg-fill ~/Pictures/Wallpapers
    fi
}

slideshow() {
    while : ; do
        change_wallpapers
        sleep 900
    done
}

case $1 in
    --now)  change_wallpapers ;;
    *)      slideshow ;;
esac
