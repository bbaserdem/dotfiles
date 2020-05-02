#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#################
#  ___ ___ _ _  #
# |  _| . | | | #
# |___|  _|___| #
#     |_|       #
#################
# CPU module;
#  * Taken no arguments
if [ -z "${SYSINFO_CPU_POLL}" ] ; then
  SYSINFO_CPU_POLL=30
fi
click_right  () {
  ( flock --nonblock 7 || exit 7
    if [ -x "${TERMINAL}" ] && [ -x '/usr/bin/htop' ] ; then
      "${TERMINAL}" /usr/bin/htop
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  # Example pre-amble
  pre=' '
  suf=''
  feature=''
  # If there is no loadavg; exit
  if [ ! -e '/proc/loadavg' ] ; then
    empty_output
    exit 1
  fi
  # Get data from /proc/loadavg
  data="$(cat /proc/loadavg)"
  # Get average load for last minute
  txt="$(echo "${data}" | awk '{printf("%.1f",$1)}')"
  # Print string
  formatted_output
}
print_loop () {
  while : ; do
    print_info || exit
    sleep "${SYSINFO_CPU_POLL}"
  done
}
