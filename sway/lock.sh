#!/usr/bin/sh
_bkg=/tmp/screen.png
swaygrab "${_bkg}"
convert "${_bkg}" -scale 10% -scale 1000% "{_bkg}"
# convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
swaylock --image "${_bkg}"
