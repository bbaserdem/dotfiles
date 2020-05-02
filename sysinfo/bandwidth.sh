#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#########################################
#  _             _       _   _ _   _    #
# | |_ ___ ___ _| |_ _ _|_|_| | |_| |_  #
# | . | .'|   | . | | | | | . |  _|   | #
# |___|__,|_|_|___|_____|_|___|_| |_|_| #
#########################################
# Bandwidth module;
#  * Can specify interface; or left to default
if [ -z "${SYSINFO_BW_POLL}" ] ; then
  SYSINFO_BW_POLL=10
fi
print_info () {
  # Example pre-amble
  feature=''
  pre='龍 '
  # Get the interface
  if [ "${instance}" = 'default' ] ; then
    intfc="$(ip route | awk '/^default via/ {print $5}')"
    # If no interface is available; exit without breaking flow
    if [ -z "${intfc}" ] ; then
      empty_output
      exit
    fi
  else
    intfc="${instance}"
    # Check if valid interface; and quit if it's not
    int_list="$(ip addr | awk -F ': ' '/^[0-9]+/ {print $2}')"
    if echo "${int_list}" | grep --quiet --invert-match "${intfc}" ; then
      empty_output
      exit 1
    fi
  fi
  # Grab these quantities; rx is download and tx is upload
  rx_now="$(cat "/sys/class/net/${intfc}/statistics/rx_bytes")"
  tx_now="$(cat "/sys/class/net/${intfc}/statistics/tx_bytes")"
  ti_now="$(date +%s)"
  # Use reserved tmpfs for storing quantities
  shmpath="/dev/shm/$(basename "$0")-${intfc}"
  # If the cache file is not present; display some text
  if [ ! -f "${shmpath}" ] ; then
    feature='mute'
    txt='Calculating…'
  else # If not; then calculate average upload/download
    # Read old data
    ti_old="$(awk '{print $1}' < "${shmpath}")"
    rx_old="$(awk '{print $2}' < "${shmpath}")"
    tx_old="$(awk '{print $3}' < "${shmpath}")"
    # Sanity check
    ti_del=$(( ti_now - ti_old ))
    if [ "${ti_del}" -le 0 ] ; then
      empty_output
      exit
    fi
    # Calculate byte/s transfer; and convert to KiB using byte shifting
    rx_rate=$(( ( ( rx_now - rx_old ) / ti_del ) >> 10 ))
    tx_rate=$(( ( ( tx_now - tx_old ) / ti_del ) >> 10 ))
    # Start formatting; use MiB when appropriate
    if [ "${rx_rate}" -gt 1024 ] ; then
      rx_rate="$(echo "${rx_rate}" | awk '{printf("%.1f", $1 / (2^10));}')"
      rx_suf='MiB/s'
    else
      rx_suf='KiB/s'
    fi
    if [ "${tx_rate}" -gt 1024 ] ; then
      tx_rate="$(echo "${tx_rate}" | awk '{printf("%.1f", $1 / (2^10));}')"
      tx_suf='MiB/s'
    else
      tx_suf='KiB/s'
    fi
    # Format text
    txt="${rx_rate} ${rx_suf}   ${tx_rate} ${tx_suf} "
  fi
  # Write to shm path
  echo "${ti_now} ${rx_now} ${tx_now}" > "${shmpath}"
  # Print string
  formatted_output
}

print_loop () {
  while : ; do
    print_info
    sleep "${SYSINFO_BW_POLL}"
  done
}
