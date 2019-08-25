#!/bin/sh

# Load workspace names
. $XDG_CONFIG_HOME/bspwm/window_id.sh

# Rename variables for easy access
wid=$1
class=$2
instance=$3
title="$(xwininfo -id $1 | awk 'NR==2' | sed 's|.*"\(.*\)"$|\1|')"

get_dropdown_flags() {
    drop_padding=120
    drop_height=420
    width="$(bspc wm --dump-state|jq -r '.monitors[].rectangle.width'|head -n1)"
    height="$(bspc wm --dump-state|jq -r '.monitors[].rectangle.height'|head -n1)"
    x_cor="$((drop_padding/2))"
    y_cor="$((height-drop_height))"
    drop_width="$((width-drop_padding))"
    drop_geom="${drop_width}x${drop_height}+${x_cor}+${y_cor}"
    echo "state=floating sticky=on hidden=on rectangle=${drop_geom}"
}

# Defaults
STATE=""
DESKTOP=""
FLAGS=""

# Grab info
case $class in
    # Force tiling
    Soffice|libreoffice*|zathura|Zathura)
        STATE="tiled";;&
    # Desktop 1: Internet
    Skype|Hamsket|qutebrowser|Firefox)
        DESKTOP="${ws1}";;
    # Desktop 2: Terminals
    Alacritty|kitty)
        DESKTOP="${ws2}";;
    # Desktop 3: Settings
    Pavucontrol|Syncthing*|System*|Blueman*|Picard*)
        DESKTOP="${ws3}";;
    # Desktop 4: Images
    Gimp*|inkscape|imv|Darktable)
        DESKTOP="${ws4}";;
    # Desktop 5: Text
    Zathura|Evince|libreoffice*|Soffice)
        DESKTOP="${ws5}";;
    # Desktop 6: Science
    MATLAB*|*Octave|Spyder*)
        DESKTOP="${ws6}";;
    # Desktop 7: Other desktops
    Qemu*|Virt-manager|*Remmina)
        DESKTOP="${ws7}";;
    # Desktop 8: Creative
    pdfsam|Blender|openscad|Picard*|Audacity|TuxGuitar)
        DESKTOP="${ws8}";;
    # Desktop 9: Gaming
    Steam|Stepmania)
        DESKTOP="${ws9}";;
    # Desktop 10: Video
    mpv|smplayer|vlc)
        DESKTOP="${ws0}";;
esac

# Title overrides
case $title in
    # Override the dropdown terminal to it's specific thing
    dropdown)
        FLAGS="$(get_dropdown_flags)"
        DESKTOP=''
        STATE=''
        ;;
    # Science figures go to image window
    Figures*)
        if [ "${DESKTOP}" = "${ws6}" ]; then
            DESKTOP="${ws4}"
        fi
        ;;
    # Save prompts do not go to a new desktop
    Save*)
        DESKTOP=""
        ;;
esac
        
# Add desktop and state flags
if [ ! -z "${DESKTOP}" ] ; then
    if [ -z "${FLAGS}" ] ; then
        FLAGS="desktop=${DESKTOP}"
    else
        FLAGS="${FLAGS} desktop=${DESKTOP}"
    fi
fi
if [ ! -z "${STATE}" ] ; then
    if [ -z "${FLAGS}" ] ; then
        FLAGS="state=${STATE}"
    else
        FLAGS="${FLAGS} state=${STATE}"
    fi
fi

# Payload
echo "${FLAGS}"
