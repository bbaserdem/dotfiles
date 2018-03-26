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

MON_WORK_0="DP-2"
MON_WORK_1="DVI-I-0"
MON_HOME_0="eDP-1"
MON_HOME_1="HDMI-2"

# Multiple monitor setup
if [[ $(hostname) == 'sbplaptop' ]]
then
    # Laptop
    xrandr --output $MON_HOME_0 --mode 1920x1080 --output $MON_HOME_1 --mode 1920x1080 --same-as $MON_HOME_0
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    # Workstation
    xrandr --output $MON_WORK_0 --mode 1920x1080 --primary
    xrandr --output $MON_WORK_1 --mode 1920x1080 --left-of $MON_WORK_0
fi

# Start i3
exec i3
