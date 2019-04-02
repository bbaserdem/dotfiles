#!/bin/sh

# Depends on maim and i3lock

# Exit if the screen is locked
[ "$(pgrep -x i3lock | wc -l)" -gt 0 ] && exit
[ "$(pgrep -x lock.sh | wc -l)" -gt 2 ] && exit

# Create directory if does not exist
_dir="${XDG_CACHE_HOME:-~/.cache/bspwm}"
[ -d "${_dir}" ] || mkdir -p "${_dir}"
_img="${_dir}/lockscreen.png"

maim | convert - -scale 10% -scale 1000% "${_img}"
# convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock --show-failed-attempts --image="${_img}" --nofork
