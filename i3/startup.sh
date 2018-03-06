#!/bin/sh
# Execute programs

dunst &
poly-launch.sh &
udiskie &
redshift &
mpd &
mpdscribble --conf $XDG_CONFIG_HOME/mpd/mpdscribble.conf &
# Make sure syncthing-gtk launches daemon if cant find it.
syncthing-gtk --minimized &
#XDG_CURRENT_DESKTOP=GNOME syncthing-gtk --minimized &

# Just workspace things
if [[ $(hostname) == 'sbpworkstation' ]]
then
    # Start dropbox
    dropbox &
fi

