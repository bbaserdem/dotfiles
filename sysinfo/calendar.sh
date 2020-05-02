#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

###################################
#          _           _          #
#  ___ ___| |___ ___ _| |___ ___  #
# |  _| .'| | -_|   | . | .'|  _| #
# |___|__,|_|___|_|_|___|__,|_|   #
###################################
# Calendar module (depends on khal)
#  * Can specify location using SYSINFO_CAL_LOC
if [ -z "${SYSINFO_CAL_LOC}" ] ; then
  SYSINFO_CAL_LOC="${HOME}/Documents/Calendar"
fi
if [ -z "${SYSINFO_CAL_MAXLEN}" ] ; then
  SYSINFO_CAL_MAXLEN=30
fi
click_right  () {
  ( flock --nonblock 7 || exit 7
    if [ -x "${TERMINAL}" ] && [ -x '/usr/bin/khal' ] ; then
      "${TERMINAL}" /usr/bin/khal interactive
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  feature=''
  suf=''
  pre=' '
  # Disable module if calendar does not exist
  if [ ! -d "${SYSINFO_CAL_LOC}" ] ; then
    empty_output
    exit 1
  fi
  # Get fields
  txt="$(/usr/bin/khal at | head -n 1)"
  # Mute if quiet
  if [ "${txt}" = 'No events' ] ; then
    feature='mute'
  fi
  # Shorten text
  if [ "$(echo "${txt}" | wc --chars)" -gt "${SYSINFO_CAL_MAXLEN}" ] ; then
    txt="$(echo "${txt}" | awk "{print substr(\$0, 1, ${SYSINFO_CAL_MAXLEN})}")…"
  fi
  # Print
  formatted_output
}

print_loop () {
  print_info || exit
  # Place inotify watch on the calendar directory, or exit gracefully
  while : ; do
    inotifywait --recursive --timeout -1 \
      --event modify --event move --event create --event delete \
      "${SYSINFO_CAL_LOC}" >/dev/null 2>&1 || exit 2
    print_info || exit
    # Wait a while before trying to add watches again
    sleep 5
  done
}
