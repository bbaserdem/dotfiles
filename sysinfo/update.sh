#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#############################
#            _     _        #
#  _ _ ___ _| |___| |_ ___  #
# | | | . | . | .'|  _| -_| #
# |___|  _|___|__,|_| |___| #
#     |_|                   #
#############################
# Update module
#  * Does not take arguments; but polling can be changed
if [ -z "${SYSINFO_UPDATE_POLL}" ] ; then
  SYSINFO_UPDATE_POLL=900
fi
click_right  () {
  dis="$(lsb_release --id | awk -F ':\\s' '{print $2}')"
  ( flock --nonblock 7 || exit 7
    case "${dis}" in
      Arch)   if [ -x '/usr/bin/pamac'    ] ; then /usr/bin/pamac    ; fi ;;
      Gentoo) if [ -x '/usr/bin/porthole' ] ; then /usr/bin/porthole ; fi ;;
    esac
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  dis="$(lsb_release --id | awk -F ':\\s' '{print $2}')"
  suf=''
  feature='mute'
  case "$(lsb_release --id | awk -F ':\\s' '{print $2}')" in
    Arch)
      pre=' '
      if [ -x '/usr/bin/checkupdates' ] ; then
        txt="$(checkupdates 2>/dev/null | wc --lines)"
      else
        empty_output
        exit 1
      fi
      ;;
    Gentoo)
      pre=' '
      if [ -x '/usr/bin/eix' ] ; then
        txt="$(eix --installed --upgrade 2>/dev/null | wc --lines)"
      else
        empty_output
        exit 1
      fi
      ;;
    *) # Exit if not configured
      empty_output
      exit 1
      ;;
  esac
  if [ "${txt}" -gt 0 ] ; then
    feature=''
  fi
  # Print string
  formatted_output
}

print_loop () {
  while : ; do
    print_info
    sleep "${SYSINFO_UPDATE_POLL}"
  done
}
