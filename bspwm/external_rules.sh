#!/bin/bash

# Rename variables for easy access
wid=$1
class=$2
instance=$3
title="$(xwininfo -id "${wid}" | awk 'NR==2' | sed 's|.*"\(.*\)"$|\1|')"

# Defaults
STATE=""
DESKTOP=""
FLAGS=""

# Grab info
case $class in
    # Dropdown override
    'Dropdown terminal')
        FLAGS="sticky=on hidden=on"
        STATE='floating'
        ;;
    # Force tiling
    Soffice|libreoffice*|zathura|Zathura|Steam|dropbox)
        STATE="tiled";;&
    # Desktop 1: Internet
    Hamsket|qutebrowser|firefox)
        DESKTOP="${ws1}";;
    # Desktop 2: Computation
    MATLAB*|*Octave|Spyder*)
        DESKTOP="${ws2}";;
    # Desktop 3: Video, media
    mpv|smplayer|vlc|cantata)
        DESKTOP="${ws3}";;
    # Desktop 4: Gaming
    Steam|Stepmania)
        DESKTOP="${ws4}";;
    # Desktop 5: Other desktops
    Qemu*|Virt-manager|*Remmina|transmission*|Skype|zoom)
        DESKTOP="${ws5}";;
    # Desktop 6: Terminals
    kitty)
        DESKTOP="${ws6}";;
    # Desktop 2: Images and Static Media
    Gimp*|inkscape|imv|Darktable)
        DESKTOP="${ws7}";;
    # Desktop 8: Writing
    Zathura|Evince|libreoffice*|Soffice)
        DESKTOP="${ws8}";;
    # Desktop 9: Creative
    pdfsam|Blender|openscad|Picard*|Audacity|TuxGuitar)
        DESKTOP="${ws9}";;
    # Desktop 10: Settings
    Pavucontrol|Syncthing*|dropbox|System*|Blueman*|Picard*|Maestral*|Pamac*|Ibus*|Firewall*)
        DESKTOP="${ws0}";;
esac

# Instance overrides
case $instance in
    # Override matlab dialogs
    'sun-awt-X11-XDialogPeer')
        DESKTOP=""
        ;;&
esac

# Title overrides
case $title in
    # Override the dropdown terminal to be floating and sticky
    Dropdown*)
        FLAGS="sticky=on hidden=on"
        DESKTOP=''
        STATE='floating'
        ;;
    # Science figures go to image window
    Figures*)
        if [ "${DESKTOP}" = "${ws2}" ]; then
            DESKTOP="${ws7}"
        fi
        ;;
    # Steam prompts go to steam window
    Steam)
        DESKTOP="${ws4}"
        ;;
    # Save prompts do not go to a new desktop
    Export*|Save*|Open*|Quit*|File*|Insert*|Confirm*|Playlist*|TabCompletionPopup|Leave*|*Overlay*)
        DESKTOP=""
        ;;
    # Zoom meeting go to remote
    'Zoom Meeting ID'*)
        DESKTOP="${ws5}"
        ;;
    # Put presentation in media
    'Presenting'*)
        DESKTOP="${ws3}"
        ;;
esac

# Add desktop and state flags
if [ -n "${DESKTOP}" ] ; then
    if [ -z "${FLAGS}" ] ; then
        FLAGS="desktop=${DESKTOP}"
    else
        FLAGS="${FLAGS} desktop=${DESKTOP}"
    fi
    # If the monitor of the requested desktop has empty focused window,
    #   switch to the newly populated desktop
    MONITOR="$(bspc query --desktop "${DESKTOP}" --monitors)"
    MONISEMPTY="$(bspc query --monitor "${MONITOR}" --tree |
        jq --raw-output '.focusedDesktopId as $id |
            .desktops[] | select(.id == $id) | .root == null')"
    if [ "${MONISEMPTY}" = 'true' ] ; then
        bspc desktop --focus "${DESKTOP}"
    fi
fi

if [ -n "${STATE}" ] ; then
    if [ -z "${FLAGS}" ] ; then
        FLAGS="state=${STATE}"
    else
        FLAGS="${FLAGS} state=${STATE}"
    fi
fi


# Payload
echo "${FLAGS}"
