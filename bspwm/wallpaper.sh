#!/bin/sh
# Script to change wallpapers, with different options for office and home

# https://gkbrk.com/2018/02/simple-dbus-service-in-python/

# Create the crontab file if does not exist
_CRON="${HOME}/.cache"
[ -d "${_CRON}" ] || mkdir -p "${_CRON}"
_CRON="${_CRON}/crontab.cron"
[ -f "${_CRON}" ] || touch "${_CRON}"

# This script location
_LOC="${HOME}/.config/bspwm/wallpaper.sh"

# Set default directory
if [[ $(hostname) == 'sbpworkstation' ]]; then
    _DIR="${HOME}/Pictures/Wallpapers/Dual/"
else
    _DIR="${HOME}/Pictures/Wallpapers"
fi

# Initialize display
_DIS="${DISPLAY}"

# Interval
_INT="15"

# Help text
print_usage() {
    echo "Usage:"
    echo "    -h            Help (print this message)"
    echo "    -s            Start slideshow"
    echo "    -k            Stop slideshow"
    echo "    -i=INTERVAL   Set interval in minutes"
    echo "    -d=DIR        Directory"
    echo "    -m=DISPLAY    Override display name\n"
}


while getopts ':hski:d:m:' flag; do
    case "${flag}" in
        h) print_usage ;;
        s) _SHW='true' ;;
        k) _SHW='false' ;;
        i) _INT="${OPTARG}" ;;
        d) _DIR="${OPTARG}" ;;
        m) _DIS="${OPTARG}" ;;
        \:) echo "Invalid option: $OPTARG requires an argument" 1>&2 ;;
        \?) print_usage ; exit 1 ;;
    esac
done

# Check image directory
if [ ! -d "${_DIR}" ]; then
    echo "Invalid directory\n" 1>&2
    exit 2
fi

# Guess display if was empty
[ -z "${_DIS}" ] && _DIS=':0'

change_background () {
    DISPLAY="${_DIS}" feh --no-fehbg --randomize --bg-scale --no-xinerama "${_DIR}"
}

# Change background
if [ -z "${_SHW}" ]; then
    change_background
# Clean crontab if slideshow is requested
else
    # Clean the line with the current display
    sed -i "/-m ${_DIS}/d" "${_CRON}"
    
    # Append line if wanted to start slideshow
    if [ "${_SHW}" == 'true' ]; then
        echo "*/${_INT} * * * * ${_LOC} -d ${_DIR} -m ${_DIS}" >> "${_CRON}"
        change_background
    fi

    fcrontab "${_CRON}"
fi
