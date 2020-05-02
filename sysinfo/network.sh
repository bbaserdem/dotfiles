#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

###################################
#          _                 _    #
#  ___ ___| |_ _ _ _ ___ ___| |_  #
# |   | -_|  _| | | | . |  _| '_| #
# |_|_|___|_| |_____|___|_| |_,_| #
###################################
# Network module;
#  * Either fixes an interface using instance; or picks it using ip route
#  * Expects the interfaces to be labelled ethernet or wifi
print_info () {
  pre=''
  # Get the interface
  if [ "${instance}" = 'default' ] ; then
    intfc="$(ip route | awk '/^default via/ {print $5}')"
    # Exit if there isn't anything
    if [ -z "${intfc}" ] ; then
      empty_output
      exit
    fi
  else
    intfc="${instance}"
    int_list="$(ip addr | awk -F ': ' '/^[0-9]+/ {print $2}')"
    # Check if valid interface
    if echo "${int_list}" | grep --quiet --invert-match "${intfc}" ; then
      exit 1
    fi
  fi
  # Get icon
  case "${intfc}" in
    eth*|en*) pre=' ' ;;
    wifi|wl*) pre=' ' ;;
    tether)   pre='禍 ' ;;
    blue*)    pre=' ' ;;
    lan*)     pre=' ' ;;
    *)        pre='爵 ' ;;
  esac
  # Get IP address for everybody
  txt="$(ip addr show "${intfc}" 2>/dev/null | awk '/inet/ {print $2}' | head -n 1)"
  if [ -z "${txt}" ] ; then
    txt='N/A'
  fi
  # Get SSID if also wireless
  if [ "${txt}" = 'wifi' ] || echo "${txt}" | grep --quiet 'wl' ; then
    info="$(iwctl station "${intfc}" get-networks rssi-dbms \
      | sed 's/\x1B\[[0-9;]\+[A-Za-z]//g' | sed --quiet '/^\s*>/p')"
    ssid="$(echo "${info}" | awk '{print $2}')"
    #strn="$(echo "${info}" | awk '{print $4}')"
    if [ -n "${ssid}" ] ; then
      txt="${ssid}  ${txt}"
    fi
  fi
  # Print info
  formatted_output
}
print_loop () {
  while : ; do
    print_info || exit
    # Wait for one line; then chillax a bit
    ( ip monitor & echo "${!}" && wait ) | ( 
      trap 'kill "${thispid}"; trap - EXIT' EXIT
      thispid="$(head -1)"
      grep --max-count=1 --quiet --line-buffered ''
    )
    sleep .2
  done
}
