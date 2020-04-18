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
    #---Kill all running polybars on this display
    pgrep 'polybar' | while IFS= read -r _pid ; do
        # Check the DISPLAY variable of this instance is the same with this one
        #   and terminate that bar if it is
        _dvar="$( \
          ( tr '\0' '\n' | awk -F '=' '/DISPLAY/ {print $2}' ) \
          < "/proc/${_pid}/environ")"
        if [ "${_dvar}" = "${DISPLAY}" ]; then
            kill "${_pid}"
        fi
        # Wait until graceful exit of this instance
        while kill -0 "${_pid}" >/dev/null 2>&1 ; do
            sleep 0.2
        done
    done

    #---Launch polybar on all monitors
    polybar --list-monitors | while IFS= read -r _pom ; do

        #--Format log location
        _mon="$(awk --field-seperator='[ ,:]' '{print $1}' <<< "${_pom}")"
        _log="${XDG_DATA_HOME}/polybar/log-${DISPLAY}-${_mon}"
        if [ ! -d "$(dirname "${_log}")" ] ; then
            mkdir -p "$(dirname "${_log}")"
        fi
        export POLYMON="${_mon}"

        #--Get the horizontal resolution to differentiate hidpi
        _hor="$(sed 's|.* \([0-9]\+\)x[0-9]\+.*|\1|' <<< "${_pom}")"
        if [ "${_hor}" -gt '2000' ] ; then
            _suf='-hi'
        else
            _suf=''
        fi

        # Launch the bars
        if grep -q 'primary' <<< "${_pom}" ; then
            # Launch the main bars
            polybar --reload "top${_suf}" </dev/null >"${_log}-t" 2>&1 & disown
            polybar --reload "bot${_suf}" </dev/null >"${_log}-b" 2>&1 & disown
        else
            # Launch an auxillary bar
            polybar --reload "aux${_suf}" </dev/null >"${_log}-a" 2>&1 & disown
        fi
    done

    # Close the file lock placed
    flock --unlock 200
) 200>"${lock}"
