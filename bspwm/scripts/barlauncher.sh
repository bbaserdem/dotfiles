#!/bin/bash
# This script reloads all polybar instances for bspwm.
#(!)Only the instances on this desktop are loaded.
# Polybar should have the following bar layouts;
# * btop * btop-hi
# * bbot * bbot-hi
# * baux * baux-hi

# Fail if DISPLAY is not set
if [ -z "${DISPLAY}" ] ; then
  echo "DISPLAY not set; must be run from X graphical session."
  exit 1
fi

# Create directories for locks to avoid race conditions
if [ -n "${XDG_CACHE_HOME}" ] ; then
  lock="${XDG_CACHE_HOME}/polybar/bars.at.${DISPLAY}.lock"
  # Create subdirectory for our lock file
  if [ ! -e "$(dirname "${lock}")" ] ; then
    mkdir -p "$(dirname "${lock}")"
  elif [ ! -d "$(dirname "${lock}")" ] ; then
    echo "Lock directory location is not a directory!"
    exit 2
  fi
else
  lock="/tmp/polybars.at.${DISPLAY}.lock"
fi

# Initialize log location
if [ -n "${XDG_DATA_HOME}" ] ; then
  logd="${XDG_DATA_HOME}/polybar"
  if [ ! -e "${logd}" ] ; then
    mkdir -p "${logd}"
  elif [ ! -d "${logd}" ] ; then
    echo "Log directory location is not a directory!"
    exit 2
  fi
else
  logd="/tmp"
fi

# Run this code block
( flock 200
  #---Kill all running polybars on this display
  pgrep 'polybar' | while IFS= read -r _pid ; do
    if [ "${_pid}" != "$$" ] ; then
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
    fi
  done

  #---Launch polybar on all monitors
  polybar --list-monitors | while IFS= read -r _pom ; do
    #--Format log location
    _mon="$(awk -F '[ ,:]' '{print $1}' <<< "${_pom}")"
    _log="${logd}/log-bspwm-${DISPLAY}-${_mon}"
    if [ -e "${_log}" ] ; then
      rm --recursive --force "${_log}"
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
      polybar --reload "bspwm-top${_suf}" </dev/null >"${_log}-t" 2>&1 & disown
      polybar --reload "bspwm-bot${_suf}" </dev/null >"${_log}-b" 2>&1 & disown
    else
      # Launch an auxillary bar
      polybar --reload "bspwm-aux${_suf}" </dev/null >"${_log}-a" 2>&1 & disown
    fi
  done

  # Close the file lock placed
  flock --unlock 200
) 200>"${lock}"
