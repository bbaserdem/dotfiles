#!/bin/bash

# Dropdown implementation
_NAME='Dropdown terminal'

# Create lock to avoid race conditions
if [ -n "${XDG_CACHE_HOME}" ] ; then
    tdir="${XDG_CACHE_HOME}/bspwm"
    lock="${tdir}/dropdown@${DISPLAY}.lock"
    # Create subdirectory for our temporary files
    if [ ! -e "${tdir}" ] ; then
        mkdir -p "${tdir}"
    elif [ ! -d "${tdir}" ] ; then
        echo "Temp directory location is not a directory!"
        exit 1
    fi
else
    lock="/var/tmp/bspwm.dropdown@${DISPLAY}.lock"
fi

# Create logfile
if [ -n "${XDG_DATA_HOME}" ] ; then
    ldir="${XDG_DATA_HOME}/bspwm"
    logf="${ldir}/dropdown@${DISPLAY}.log"
    # Create subdirectories
    if [ ! -e "${ldir}" ] ; then
        mkdir -p "${ldir}"
    elif [ ! -d "${ldir}" ] ; then
        echo "Local directory location is not a directory!"
        exit 2
    fi
else
    logf="/tmp/bspwm.dropdown@${DISPLAY}.log"
fi

# Spawn (only 1) terminal
spawn_terminal () {
    # Open the lock file; or exit with error
    ( flock -n 201 || exit 1
    /usr/bin/kitty --class "${_NAME}" </dev/null >"${logf}" 2>&1 & disown
    # Output PID
    echo $!
    ) 201>"${lock}"
}

calculate_movement () {
    _NEW="$(bspc wm --dump-state | jq --compact-output '
        .focusedMonitorId as $mid | 
        .monitors[] |
        select(.id == $mid) |
        (.rectangle.height - .padding.bottom - .padding.top ) as $h |
        (.rectangle.width  - .padding.right  - .padding.left) as $w |
        (.rectangle.x + .padding.left) as $x |
        (.rectangle.y + .padding.top ) as $y |
        {
            x: ($x + (($w - ($w % 40)) / 40)) ,
            y: ($y) ,
            height: (($h - ($h % 3)) / 3) ,
            width: (($w - ($w % 20)) * 19 / 20)
        }')"
    _CUR="$(bspc query --node "${1}" --tree |
        jq --compact-output '.client.floatingRectangle')"
    echo "{\"current\": ${_CUR}, \"new\": ${_NEW}}" | jq '
        {
            origin:
            {
                dx: (.new.x - .current.x),
                dy: (.new.y - .current.y)
            },
            corner:
            {
                dx: (.new.width  - .current.width),
                dy: (.new.height - .current.height)
            }
        }'
}

#   Get window ID of dropdown terminal
#   If the dropdown window does not exist;
#       - Spawns a dropdown terminal
#       - Get window ID of said terminal
_WID="$(xdotool search --class "${_NAME}")"
if [ -z "${_WID}" ] ; then
    _PID="$(spawn_terminal)"
    # If PID is empty; new terminal can't be launched.
    # It might have been launched very recently; in that case wait.
    if [ -z "${_PID}" ] ; then
        sleep 1
        _WID="$(xdotool search --class "${_NAME}")"
    else
        _WID="$(xdotool search --pid "${_PID}")"
    fi
fi

# If the window ID can't be gotten; just give up
if [ -z "${_WID}" ] ; then
    exit 1
fi

# Make the dropdown terminal floating
#   If the window is hidden
#       - Reshape to the active monitor
#       - Make not-hidden, and focus
#   Else
#       - Make hidden
if [ "$(bspc query --node "${_WID}" --tree | jq '.hidden')" = 'true' ] ; then
    # Get transformation
    _GEO="$(calculate_movement "${_WID}")"
    echo "$_GEO"
    echo "${_GEO}" | jq
    _OR_X="$(echo "${_GEO}" | jq --raw-output '.origin.dx')"
    _OR_Y="$(echo "${_GEO}" | jq --raw-output '.origin.dy')"
    _CO_X="$(echo "${_GEO}" | jq --raw-output '.corner.dx')"
    _CO_Y="$(echo "${_GEO}" | jq --raw-output '.corner.dy')"
    # Move the origin
    bspc node "${_WID}" --move   "${_OR_X}" "${_OR_Y}"
    bspc node "${_WID}" --resize bottom_right "${_CO_X}" "${_CO_Y}"
    # Toggle and focus
    bspc node "${_WID}" --flag hidden=off --focus
else
    bspc node "${_WID}" --flag hidden=on
fi
