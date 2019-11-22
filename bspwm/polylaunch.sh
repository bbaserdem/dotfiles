#!/bin/bash

# This script reloads all polybar instances
(
    flock 200
    # Get PID of all processes that we want
    pgrep 'polybar' | while IFS= read -r _pid ; do
        # Check environment variables
        _disp="$(cat "/proc/${_pid}/environ" | tr '\0' '\n' | sed -n 's|DISPLAY=\(.*\)|\1|p')"
        if [ "${_disp}" = "$DISPLAY" ]; then
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
) 200>/var/tmp/polybar-"${DISPLAY}"-launch.lock
