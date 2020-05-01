#!/bin/dash

# Depends on grim and swaylock

# Exit if the screen is locked
[ "$(pgrep -x swaylock | wc -l)" -gt 0 ] && exit
[ "$(pgrep -x lock.sh | wc -l)" -gt 2 ] && exit

# Create directory if does not exist
if [ -z "${XDG_CACHE_HOME}" ] ; then
    _dir="${HOME}/.cache/sway"
else
    _dir="${XDG_CACHE_HOME}/sway"
fi

mkdir -p "${_dir}"
_img="${_dir}/lockscreen.png"

# Get a screenshot
grim - | convert - -scale 10% -scale 1000% "${_img}"
# convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
swaylock --config ~/.config/sway/lock.conf --show-failed-attempts --show-keyboard-layout --indicator-caps-lock --image="${_img}"
