#!/bin/bash

# Create directory if does not exist
if [ -z "${XDG_CACHE_HOME}" ] ; then
    _dir="/tmp"
else
    _dir="${XDG_CACHE_HOME}/sbp-xlock"
    if [ -x "${_dir}" ] && [ ! -d "${_dir}" ] ; then
        echo 'Cache directory is a file'
        exit 1
    elif [ ! -x "${_dir}" ] ; then
        mkdir -p "${_dir}"
    fi
fi
_img="${_dir}/lockscreen.png"
_lock="${_dir}/screenlock.at.${DISPLAY}"

( flock 200
    #---Get screenshot and pixellate
    maim | convert - -scale 10% -scale 1000% "${_img}"
    #---Compose an image on top
    # convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
    #---Lock the screen
    i3lock --image="${_img}" \
        --pointer=default \
        --ignore-empty-password \
        --show-failed-attempts \
        --indicator \
        --keylayout 0 \
        --clock \
        --pass-media-keys --pass-screen-keys \
        --radius 180 \
        --bar-indicator --bar-width=50

) 200>"${_lock}"
