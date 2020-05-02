#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

###################
#    _ _     _    #
#  _| |_|___| |_  #
# | . | |_ -| '_| #
# |___|_|___|_,_| #
###################
# Disk module;
#  * Needs the an argument either of target; or root/home
if [ -z "${SYSINFO_DISK_POLL}" ] ; then
  SYSINFO_DISK_POLL=900
fi
click_right  () {
  ( flock --nonblock 7 || exit 7
    if [ -x '/usr/bin/baobab' ] ; then
      /usr/bin/baobab
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
print_info () {
  # Example pre-amble
  pre=' '
  suf=''
  if [ -d "${instance}" ] ; then
    dir="${instance}"
    txt="${instance}: "
  elif [ "${instance}" = 'default' ] || [ "${instance}" = 'root' ] ; then
    dir="/"
    txt="Root: "
  elif [ "${instance}" = 'home' ] ; then
    pre=' '
    dir="/home"
    txt="Home: "
  else
    exit 1
  fi
  prc="$(df --human-readable --portability --local \
    | awk "{if(\$6 == \"${dir}\"){print substr(\$5, 1, length(\$5)-1)}}")"
  if [ "${prc}" -gt 90 ] ; then
    feature='urgent'
    suf=' '
  fi
  txt="${txt}${prc}"
  # Print string
  formatted_output
}
print_loop () {
  while : ; do
    print_info || exit 2
    sleep "${SYSINFO_DISK_POLL}"
  done
}
