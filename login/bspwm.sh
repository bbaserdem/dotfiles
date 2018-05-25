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

if [ -d "/usr/share/fonts" ]; then
    xset fp+ /usr/share/fonts/
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

# Multiple monitor setup
if [[ $(hostname) == 'sbplaptop' ]]
then
    # Laptop
    xrandr --output $MON_0 --mode 1920x1080 --output $MON_1 --mode 1920x1080 --same-as $MON_0
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    # Workstation
    xrandr --output $MON_0 --mode 1920x1080 --primary
    xrandr --output $MON_1 --mode 1920x1080 --left-of $MON_0
elif [[ $(hostname) == 'sbphomestation' ]]
then
    # Homestation
    xrandr --output $MON_0 --mode 1920x1080 --primary
fi

# Start bspwm
exec bspwm
