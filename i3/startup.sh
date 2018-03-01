#!/bin/sh
# Execute programs

dunst &
poly-launch.sh --i3 &
udiskie &
redshift &
mpd &
mpdscribble --conf $XDG_CONFIG_HOME/mpd/mpdscribble.conf --log ~/.cache/mpdscribble.log &
# Make sure syncthing-gtk launches daemon if cant find it.
syncthing-gtk --minimized &
#XDG_CURRENT_DESKTOP=GNOME syncthing-gtk --minimized &

# Just workspace things
if [[ $(hostname) == 'sbpworkstation' ]]
then
    # Start dropbox
    dropbox &
    # Put presentation workspace on the left monitor
    i3-msg workspace 10 output DVI-I-1
fi

