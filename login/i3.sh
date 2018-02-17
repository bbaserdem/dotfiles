#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Fix for cursor being a cross
xsetroot -cursor_name left_ptr

# Systemctl signal for X is up and running
systemctl --user start X.target

# Multiple monitor setup
if [[ $(hostname) == 'sbplaptop' ]]
then
    # Laptop
    xrandr --output eDP-1 --mode 1920x1080 --output HDMI-2 --mode 1920x1080 --same-as eDP-1
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    # Workstation
    xrandr --output DP-2 --mode 1920x1080 --primary
    xrandr --output DVI-I-1 --mode 1920x1080 --right-of DP-2
fi

# Start bspwm
exec i3
