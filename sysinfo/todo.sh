#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#####################
#  _         _      #
# | |_ ___ _| |___  #
# |  _| . | . | . | #
# |_| |___|___|___| #
#####################
# Todo module (depends on todoman)
if [ -z "${SYSINFO_TODO_LOC}" ] ; then
  SYSINFO_TODO_LOC="${HOME}/Documents/Todo"
fi
if [ -z "${SYSINFO_TODO_MAXLEN}" ] ; then
  SYSINFO_TODO_MAXLEN=30
fi
print_info () {
  pre='省 '
  suf=''
  # Fail if the watch folder does not exist
  if [ ! -d "${SYSINFO_TODO_LOC}" ] ; then
    empty_output
    exit 1
  fi
  # Get the next todo task
  txt="$(todo --porcelain list --sort priority | jq -r '.[0]."summary"')"
  # Mute if quiet
  if [ "${txt}" = 'null' ] ; then
    txt='Nothing todo'
    feature='mute'
  elif [ -n "${txt}" ] ; then
    feature=''
  else
    empty_output
    exit 1
  fi
  # Shorten text
  if [ "$(echo "${txt}" | wc --chars)" -gt "${SYSINFO_TODO_MAXLEN}" ] ; then
    txt="$(echo "${txt}" | awk "{print substr(\$0, 1, ${SYSINFO_TODO_MAXLEN})}")…"
  fi
  # Print string
  formatted_output
}
print_loop () {
  print_info || exit
  # Place inotify watch on the calendar directory, or exit gracefully
  while : ; do
    inotifywait --recursive --timeout -1 \
      --event modify --event move --event create --event delete \
      "${SYSINFO_TODO_LOC}" >/dev/null 2>&1 || exit 2
    print_info
    # Wait a while before trying to add watches again
    sleep 5
  done
}
