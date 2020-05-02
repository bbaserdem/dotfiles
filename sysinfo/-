#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT


###################
#              _  #
#  _____ ___ _| | #
# |     | . | . | #
# |_|_|_|  _|___| #
#       |_|       #
###################
# MPD module;
#  * Can take instance name of; default, consume, repeat, shuffle, single, toggle
if [ -z "${SYSINFO_MPD_POLL}" ] ; then
  SYSINFO_MPD_POLL=30
fi
if [ -z "${SYSINFO_MPD_MAXLEN}" ] ; then
  SYSINFO_MPD_MAXLEN=20
fi
click_left   () {
  if [ -x '/usr/bin/mpc' ] ; then
    case "${instance}" in
      default|song)     /usr/bin/mpc toggle         >/dev/null 2>&1 ;;
      rewind)           /usr/bin/mpc seek '-10'     >/dev/null 2>&1 ;;
      fastforward)      /usr/bin/mpc seek '+10'     >/dev/null 2>&1 ;;
      *)                /usr/bin/mpc "${instance}"  >/dev/null 2>&1 ;;
    esac
  fi
}
click_middle () {
  if [ -x '/usr/bin/mpc' ] ; then
    /usr/bin/mpc stop
  fi
}
click_right  () {
  ( flock --nonblock 7 || exit 7
    if [ -x '/usr/bin/cantata' ] ; then
      /usr/bin/cantata
    elif [ -x '/usr/bin/ncmpcpp' ] && [ -x "${TERMINAL}" ] ; then
      "${TERMINAL}" '/usr/bin/ncmpcpp'
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  # Get MPD info, even if it breaks
  info="$(mpc 2>&1)"
  lines="$(echo "${info}" | wc --lines)"
  # Initialize
  txt=''
  suf=''
  pre=''
  feature=''
  # Configure output but only if;
  #  3 lines: OK (There is playback)
  #  2 lines: Might be a database update
  #  1 lines: Empty playlist (iff there is no error)
  if  [ "${lines}" = '3' ] || \
    ( [ "${lines}" = '2' ] && echo "${info}" | grep --quiet 'Updating' ) || \
    ( [ "${lines}" = '1' ] && echo "${info}" | grep --quiet --invert-match 'error' )
    then
    #---BUTTONS---#
    # Single characters; format these as txt for foreground, and prefix for accented
    if [ "${instance}" = 'next' ] ; then
      txt='怜'
    elif [ "${instance}" = 'prev' ] ; then
      txt='玲'
    elif [ "${instance}" = 'rewind' ] ; then
      txt='丹'
    elif [ "${instance}" = 'fastforward' ] ; then
      txt=''
    elif [ "${instance}" = 'random' ] ; then
      if echo "${info}" | grep --quiet "${instance}: on" ; then
        pre='列'
      else
        txt='劣'
      fi
    elif [ "${instance}" = 'repeat' ] ; then
      if echo "${info}" | grep --quiet "${instance}: on" ; then
        pre='凌'
      else
        txt='稜'
      fi
    elif [ "${instance}" = 'consume' ] ; then
      if echo "${info}" | grep --quiet "${instance}: on" ; then
        pre=''
      else
        txt=''
      fi
    elif [ "${instance}" = 'single' ] ; then
      if echo "${info}" | grep --quiet "${instance}: on" ; then
        pre='綾'
      else
        txt='綾'
      fi
    elif [ "${instance}" = 'toggle' ] ; then
      # It's playing/paused only if there are 3 lines
      if [ "${lines}" = '3' ] ; then
        if echo "${info}" | grep --quiet 'paused' ; then
          txt='契'
        else
          txt=''
        fi
      # It is stopped
      else
        txt='懶'
      fi
    elif [ "${instance}" = 'song' ] || [ "${instance}" = 'default' ] ; then
      pre=' '
      # Check if mpdscribble is working
      if pgrep mpdscribble >/dev/null 2>&1; then
        suf=' '
      fi
      # Get song title if it's playing: 3 lines
      if [ "${lines}" = '3' ] ; then
        # Add toggle to suffix
        if echo "${info}" | grep --quiet 'paused' ; then
          suf="${suf} "
        else
          suf="${suf} 契"
        fi
        tit="$(echo "${info}" | sed --quiet '1p' | awk -F ' - ' '{print $2}')"
        art="$(echo "${info}" | sed --quiet '1p' | awk -F ' - ' '{print $1}')"
        # Shorten fields
        if [ "$(echo "${tit}" | wc --chars)" -gt "${SYSINFO_MPD_MAXLEN}" ] ; then
          tit="$(echo "${tit}" \
            | awk "{print substr(\$0, 1, ${SYSINFO_MPD_MAXLEN})}")…"
        fi
        if [ "$(echo "${art}" | wc --chars)" -gt "${SYSINFO_MPD_MAXLEN}" ] ; then
          art="$(echo "${art}" \
            | awk "{print substr(\$0, 1, ${SYSINFO_MPD_MAXLEN})}")…"
        fi
        txt="${tit}  ${art}"
        # Mute if paused
        if echo "${info}" | grep --quiet 'paused' ; then
          feature='mute'
        fi
      elif  [ "${lines}" = '2' ] ; then
        txt='Database update…'
        feature='mute'
        suf="${suf} 懶"
      else
        txt='Empty playlist…'
        feature='mute'
      fi
    fi
  # If none of the conditions are satisfied; just apply a disconnect suffix to default
  elif [ "${instance}" = 'song' ] || [ "${instance}" = 'default' ] ; then
    pre='ﱙ'
    # Check if mpdscribble is working
    if pgrep mpdscribble >/dev/null 2>&1; then
      suf=' '
    fi
  fi
  # Print string
  formatted_output
}

print_loop () {
  print_info
  # Retry to connect every 30 seconds if the mpc command gives error
  if [ -x '/usr/bin/mpc' ] ; then
    while : ; do
      while : ; do
        /usr/bin/mpc --quiet idle >/dev/null || break
        print_info
      done
      sleep "${SYSINFO_MPD_POLL}"
    done
  fi
}
