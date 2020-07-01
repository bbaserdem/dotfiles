#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#############################
#          _   _            #
#  _ _ ___| |_|_|_____ ___  #
# | | | . |  _| |     | -_| #
# |___|  _|_| |_|_|_|_|___| #
#     |_|                   #
#############################
# Uptime module
#  * Does not take arguments; but polling can be changed
if [ -z "${SYSINFO_UPTIME_POLL}" ] ; then
  SYSINFO_UPTIME_POLL=60
fi
print_info () {
  pre=' '
  time="$(uptime --pretty)"
  # Get the hours:minutes; which is <1 or 2 numbers>:<2 numbers>
  min="$(echo "${time}" | sed -n 's|.* \([0-9]\+\) minutes.*|\1|p')"
  hrs="$(echo "${time}" | sed -n 's|.* \([0-9]\+\) hours.*|\1|p')"
  day="$(echo "${time}" | sed -n 's|.* \([0-9]\+\) days.*|\1, |p')"
  sol="$(echo "${time}" | sed -n 's|.* \([0-9]\+\).*|\1, |p')"
  txt="${sol}${day}${hrs}${min}"
  # Print string
  formatted_output
}

print_loop () {
  while : ; do
    print_info
    sleep "${SYSINFO_UPTIME_POLL}"
  done
}
