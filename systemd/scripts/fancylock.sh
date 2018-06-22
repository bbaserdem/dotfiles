#!/bin/sh
TMPBG=/tmp/screen.png
maim | convert - -scale 10% -scale 1000% $TMPBG
# convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -n -f -i $TMPBG
