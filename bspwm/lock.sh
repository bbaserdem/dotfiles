#!/bin/sh

# Exit if the screen is locked
[ "$(pgrep -x i3lock | wc -l)" -gt 0 ] && exit
[ "$(pgrep -x lock.sh | wc -l)" -gt 2 ] && exit

TMPBG=/tmp/screen.png
maim | convert - -scale 10% -scale 1000% $TMPBG
# convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock --show-failed-attempts --image="${TMPBG}" --nofork
