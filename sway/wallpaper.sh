#!/bin/dash
# Script to change wallpaper of all running sway instances

bk_set () {
    if [ -e "$1" ] ; then
        _socket=$1
    else
        echo 'Socket not found'
        exit 1
    fi

    if [ $(hostname) = 'sbpworkstation' ]; then
        # Set default directory
        _dir="${HOME}/Pictures/Wallpapers/Dual/"
        # Get random image and divide it
        _img="${_dir}$(ls "${_dir}" | sort -R | head -n 1)"
        convert $_img -crop 50%x100% +repage /tmp/bg_%d.jpg
        _img1='/tmp/bg_0.jpg'
        _img2='/tmp/bg_1.jpg'
        # Get monitors
        _mon1=$(swaymsg -s $_socket -t get_outputs | jq '.[] | select(."rect"."x"==0) | ."name"' -r | head -n 1)
        _mon2=$(swaymsg -s $_socket -t get_outputs | jq '.[] | select(."rect"."x"!=0) | ."name"' -r | head -n 1)
        # Set background
        swaymsg --socket $_socket "output ${_mon1} bg ${_img1} stretch"
        swaymsg --socket $_socket "output ${_mon2} bg ${_img2} stretch"

    else
        # Set default directory
        _dir="${HOME}/Pictures/Wallpapers/"
        # Operate on all monitors
        swaymsg -s $_socket -t get_outputs -r | jq '.[]."name"' -r | while read -r _mon ; do
            _img="${_dir}$(ls "${_dir}" | sort -R | head -n 1)"
            swaymsg -s $_socket "output ${_mon} bg ${_img} stretch"
        done
    fi
}

while getopts ':a' _opt ; do
    if [ "$_opt" = 'a' ] ; then
        find /run/ -name 'sway-ipc*' 2>/dev/null | while read -r _soc ; do
            bk_set $_soc
        done
    fi
    exit 0
done

bk_set $SWAYSOCK
