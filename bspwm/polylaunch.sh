#!/bin/bash
# This script reloads all polybar instances.
# While it is used for bspwm; it is fully independent
#(!)Only the instances on this desktop are loaded.
# Polybar should have the following bar layouts;
# * top * top-hi
# * bot * bot-hi
# * aux * aux-hi

# Create directories for locks to avoid race conditions
lock="${XDG_CACHE_HOME}/polybar/bars.at.${DISPLAY}.lock"
if [ ! -d "$(dirname "${lock}")" ] ; then
    mkdir -p "$(dirname "${lock}")"
fi

# Run this code block
( flock 200
    # Iterate over all running polybar instances
    #---Kill all running polybars in this monitor
    pgrep 'polybar' | while IFS= read -r _pid ; do
        # Check the DISPLAY variable of this instance is the same with this one
        #   and terminate that bar if it is
        _dvar="$( ( tr '\0' '\n' | awk -F '=' '/DISPLAY/ {print $2}' ) \
            < "/proc/$1/environ")"
        if [ "${_dvar}" = "${DISPLAY}" ]; then
            kill "${_pid}"
        fi
        # Wait until graceful exit of this instance
        while kill -0 "${_pid}" >/dev/null 2>&1 ; do
            sleep 0.2
        done
    done

    # Get outputs from bspwm, and launch polybar on each monitor
    polybar --list-monitors | while IFS= read -r _pom ; do
        # Get the horizontal resolution number of the monitor
        _mon="$(awk '{print $1}' <<< "${_pom}")"
        _hor="$(sed 's|.* \([0-9]\+\)x[0-9]\+.*|\1|' <<< "${_pom}")"
        _log="${XDG_DATA_HOME}/polybar/log-${DISPLAY}-${_mon}"
        if [ ! -d "$(dirname "${_log}")" ] ; then
            mkdir -p "$(dirname "${_log}")"
        fi
        # Check if high-dpi need to be used
        if [ "${_hor}" -gt '2000' ] ; then
            if grep -q 'primary' <<< "${_pom}" ; then
                polybar --reload top-hi </dev/null >"${_log}-top" 2>&1 & disown
                polybar --reload bot-hi </dev/null >"${_log}-bot" 2>&1 & disown
            else
                POLYMON="${_mon}" polybar --reload aux-hi </dev/null >"${_log}-aux" 2>&1 & disown
            fi
        else
            if grep -q 'primary' <<< "${_pom}" ; then
                polybar --reload top </dev/null >"${_log}-top" 2>&1 & disown
                polybar --reload bot </dev/null >"${_log}-bot" 2>&1 & disown
            else
                POLYMON="${_mon}" polybar --reload aux </dev/null >"${_log}-aux" 2>&1 & disown
            fi
        fi
    done
    # Close the file descriptor; ending the lock
    exec 200<&-

) 200>"${lock}"
