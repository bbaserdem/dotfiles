#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#################
#  ___ ___ ___  #
# |  _|_ -|_ -| #
# |_| |___|___| #
#################
# RSS module
if [ -z "${SYSINFO_RSS_POLL}" ] ; then
  SYSINFO_RSS_POLL=600
fi
click_right  () {
  ( flock --nonblock 7 || exit 7
    if [ -x "${TERMINAL}" ] && [ -x '/usr/bin/newsboat' ] ; then
      "${TERMINAL}" '/usr/bin/newsboat'
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  if [ ! -x '/usr/bin/newsboat' ] ; then
    empty_output
    exit 1
  fi
  pre=' '
  feature=''
  suf=''
  # Read status
  tmp="$(mktemp)"
  txt="$(/usr/bin/newsboat "--cache-file=${tmp}" -x print-unread | awk '{print $1}')"
  rm "${tmp}"
  if [ -z "${txt}" ] ; then
    empty_output
    exit 1
  fi
  if [ "${txt}" = '0' ] ; then
    feature='mute'
  fi
  # Print string
  formatted_output
}

print_loop () {
  while : ; do
    print_info
    sleep "${SYSINFO_RSS_POLL}"
  done
}
