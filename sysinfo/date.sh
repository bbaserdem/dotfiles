#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#####################
#    _     _        #
#  _| |___| |_ ___  #
# | . | .'|  _| -_| #
# |___|__,|_| |___| #
#####################
# Date module
if [ -z "${SYSINFO_DATE_STYLE}" ]  ; then
  SYSINFO_DATE_STYLE='regular'
fi
print_info () {
  pre=' '
  # Get proper icon for the moon phase
  moon="$(echo "$(printf "%.0f" \
    "$(echo "scale=2; ( $(date -d "00:00" +%s) - $(date -d "1999-08-11" +%s) )/(60*60*24)" \
    | bc)") % 29.530588853" | bc | awk '{printf("%d",$1+.5)}')"
  case "${moon}" in
    0)  _out="" ;; 1)  _out="" ;; 2)  _out="" ;; 3)  _out="" ;;
    4)  _out="" ;; 5)  _out="" ;; 6)  _out="" ;; 7)  _out="" ;;
    8)  _out="" ;; 9)  _out="" ;; 10) _out="" ;; 11) _out="" ;;
    12) _out="" ;; 13) _out="" ;; 14) _out="" ;; 15) _out="" ;;
    16) _out="" ;; 18) _out="" ;; 19) _out="" ;; 20) _out="" ;;
    21) _out="" ;; 22) _out="" ;; 23) _out="" ;; 24) _out="" ;;
    25) _out="" ;; 26) _out="" ;; 27) _out="" ;; 28) _out="" ;;
    29) _out="" ;; 30) _out="" ;;
  esac
  case "${SYSINFO_DATE_STYLE}" in
    alt*) suf=" $(echo "${_out}" | awk '{print substr($0, 1, 1)}')" ;;
    *)    suf=" $(echo "${_out}" | awk '{print substr($0, 2, 1)}')" ;;
  esac
  txt="$(date '+%a, %d/%m/%Y')"
  # Print string
  formatted_output
}
print_loop () {
  while : ; do
    print_info
    # Sleep until the start of next day, (throw in a 5 sec)
    sleep "$(( $(date -d "tomorrow 0" +%s) - $(date +%s) + 5 ))"
  done
}
