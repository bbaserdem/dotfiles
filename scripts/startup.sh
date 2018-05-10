#!/bin/sh
# Execute programs, and primes system

# Set volume to 20
pactl set-sink-volume 0 '20%'
pactl set-sink-mute 0 0

# Disable beeper
xset -b

# Set backlight (does not work)
xbacklight -set 100

# Set wallpaper
wallpaper.sh

# Start programs

# X-Programs
compton -b                              # Compositor
dunst &                                 # Notification daemon
poly-launch.sh &                        # Polybar: status bar
redshift &                              # Screen dimmer

# Non-X programs
udiskie &                               # Mount manager
mpd &                                   # Music
syncthing-gtk --minimized &             # File sync manager
mpdscribble --conf $XDG_CONFIG_HOME/mpd/mpdscribble.conf &  # Scrobbler
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Just workspace things
if [[ $(hostname) == 'sbpworkstation' ]]
then
    # Start dropbox
    dropbox &
fi
