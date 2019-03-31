#!/bin/sh
# Script to change wallpapers, with different options for office and home

# Set default directory
if [[ $(hostname) == 'sbpworkstation' ]]; then
    _DIR="${HOME}/Pictures/Wallpapers/Dual/"
else
    _DIR="${HOME}/Pictures/Wallpapers"
fi

# Interval
_INT="15"

# Help text
print_usage() {
    echo "BSPWM wallpaper changer"
    echo "Usage:"
    echo "    -h            Help (print this message)"
    echo "    -d=DIR        Directory"
}


while getopts ':h:d:' flag; do
    case "${flag}" in
        d) _DIR="${OPTARG}" ;;
        h|\?) print_usage ; exit 1 ;;
    esac
done

# Check image directory
if [ ! -d "${_DIR}" ]; then
    echo "Invalid directory\n" 1>&2
    exit 2
fi

for _bpr in $(pgrep 'bspwm') ; do
    DISPLAY="$( cat "/proc/${_bpr}/environ" |
        tr '\0' '\n' |
        sed -n 's|^DISPLAY=\(.*\)$|\1|p')" \
        feh --no-fehbg --randomize --bg-scale --no-xinerama "${_DIR}"
done
