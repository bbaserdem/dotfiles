#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#######################
#                _ _  #
#  ___ _____ ___|_| | #
# | -_|     | .'| | | #
# |___|_|_|_|__,|_|_| #
#######################
# Email module (depends on inotifp)
#  * Can specify location using SYSINFO_EMAIL_LOC
if [ -z "${SYSINFO_EMAIL_LOC}" ] ; then
  SYSINFO_EMAIL_LOC="${HOME}/Documents/Mail/Gmail"
fi
click_right  () {
  ( flock --nonblock 7 || exit 7
    if [ -x "${TERMINAL}" ] && [ -x '/usr/bin/neomutt' ] ; then
      "${TERMINAL}" /usr/bin/neomutt
    elif [ -x "${TERMINAL}" ] && [ -x '/usr/bin/mutt' ] ; then
      "${TERMINAL}" /usr/bin/mutt
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  # If there is no inbox; just exit
  if [ ! -d "${SYSINFO_EMAIL_LOC}/Inbox/new" ] ; then
    empty_output
    exit 1
  fi
  # Get number of new emails
  txt="$(find "${SYSINFO_EMAIL_LOC}/Inbox/new" | wc -l)"
  # Set up prefix
  if [ "${txt}" -le 0 ] ; then
    pre=" "
    feature='mute'
  else
    pre=" "
  fi
  # Print string
  formatted_output
}

print_loop () {
  print_info || exit
  # Place inotify watch on the email directory, or exit gracefully
  while : ; do
    inotifywait --recursive --timeout -1 \
      --event modify --event move --event create --event delete \
      "${SYSINFO_EMAIL_LOC}" >/dev/null 2>&1 || exit 2
    print_info || exit
    # Wait a while before trying to add watches again
    sleep 1
  done
}
