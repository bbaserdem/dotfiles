#!/bin/bash
# This script reloads all polybar instances.
#(!)Only the instances on this desktop are loaded.
# Polybar should have the following bar layouts;
# * top * top-hidpi
# * bot * bot-hidpi
# * aux * aux-hidpi

# Create directories for locks to avoid race conditions
locn="${XDG_CACHE_HOME}/bspwm/"
lock="bars.at.${DISPLAY}.lock"
if [ ! -d "${locn}" ] ; then
    mkdir -p "${locn}"
fi

get_display_var () {
    # Get the DISPLAY variable from given PID
    ( tr '\0' '\n' | awk -F '=' '/DISPLAY/ {print $2}' ) < "/proc/$1/environ"
}

# Run this code block
( flock 200
    # Iterate over all running polybar instances
    pgrep 'polybar' | while IFS= read -r _pid ; do
        # Check the DISPLAY variable of this instance is the same with this one
        #   and terminate that bar if it is
        if [ "$(get_display_var "${_pid}")" = "${DISPLAY}" ]; then
            kill "${_pid}"
        fi
        # Wait until graceful exit
        while kill -0 "${_pid}" 2>/dev/null 1>/dev/null; do
            sleep 0.2
        done
    done

    # Get outputs from bspwm, and launch polybar on each monitor
    bspc query --names --monitors | while read m; do
        POLYMON=$m polybar --reload top </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- & disown
        POLYMON=$m polybar --reload bot </dev/null >/var/tmp/polybar-$m.log 2>&1 200>&- & disown
    done
) 200>"${locn}/${lock}"
