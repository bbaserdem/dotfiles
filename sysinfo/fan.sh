#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT


#################
#  ___          #
# |  _|___ ___  #
# |  _| .'|   | #
# |_| |__,|_|_| #
#################
# Fan module
#  * Takes optional instance
if [ -z "${SYSINFO_FAN_POLL}" ] ; then
  SYSINFO_FAN_POLL=5
fi
print_info () {
  pre=' '
  suf=''
  # Check fan output
  if [ "${instance}" = 'default' ] ; then
    int='fan'
  else
    int="${instance}"
  fi
  if [ ! -x '/usr/bin/sensors' ] ; then
    empty_output
    exit 1
  fi
  txt="$(/usr/bin/sensors | awk "/${int}/ {print \$2}")"
  if [ -z "${txt}" ] ; then
    empty_output
    exit 1
  fi
  # Print string
  formatted_output
}

print_loop () {
  while : ; do
    print_info || exit
    sleep "${SYSINFO_FAN_POLL}"
  done
}
