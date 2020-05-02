#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#################################
#  _____ ___ _____ ___ ___ _ _  #
# |     | -_|     | . |  _| | | #
# |_|_|_|___|_|_|_|___|_| |_  | #
#                         |___| #
#################################
# Memory module
if [ -z "${SYSINFO_MEM_POLL}" ] ; then
  SYSINFO_MEM_POLL=30
fi
click_right  () {
  ( flock --nonblock 7 || exit 7
    if [ -x "${TERMINAL}" ] & [ -x '/usr/bin/htop' ] ; then
      "${TERMINAL}" /usr/bin/htop
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  # Initialize
  pre=' '
  suf=''
  # Get memory info (raw and human readable
  info_raw="$(free -m)"
  info="$(free -h)"
  # Get RAM usage
  ram_perc="$(echo "${info_raw}"  | awk '/Mem:/  {printf("%.0f", $3 / $2 * 100.0);}')"
  ram_amnt="$(echo "${info}"      | awk '/Mem:/  {print $3}')"
  txt="${ram_amnt}B (${ram_perc})"
  # Get SWAP usage, and include it if sifnificant
  swap_perc="$(echo "${info_raw}" | awk '/Swap:/ {printf("%.0f", $3 / $2 * 100.0);}')"
  swap_amnt="$(echo "${info}"     | awk '/Swap:/ {print $3}')"
  if [ "${swap_perc}" -gt 0 ] ; then
    txt="${txt}樂${swap_amnt}B (${swap_perc})"
    suf=' 易'
  fi
  # Become urgent if memory usage is high
  if [ "${ram_perc}" -gt 90 ] ; then
    feature='urgent'
  fi
  # Print string
  formatted_output
}
print_loop () {
  while : ; do
    print_info
    sleep "${SYSINFO_MEM_POLL}"
  done
}
