#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#####################################
#  _           _   _ _     _   _    #
# | |_ ___ ___| |_| |_|___| |_| |_  #
# | . | .'|  _| '_| | | . |   |  _| #
# |___|__,|___|_,_|_|_|_  |_|_|_|   #
#                     |___|         #
#####################################
# Backlight module;
#  * No instance needed
scroll_up () {
  if [ -x /usr/bin/light ] ; then
    /usr/bin/light -A 1
  fi
}
scroll_down () {
  if [ -x /usr/bin/light ] ; then
    /usr/bin/light -U 1
  fi
}
print_info () {
  suf=''
  feature=''
  # Get the current brigtness value; in whole percent
  txt="$(/usr/bin/light -Gs 'sysfs/backlight/auto' 2>/dev/null \
    | awk '{printf "%.0f", $1}')"
  if [ -z "${txt}" ] ; then
    empty_output
    exit 1
  fi
  # Determine the screen icon icon
  if   [ "${txt}" -ge 75 ] ; then pre=" "
  elif [ "${txt}" -ge 50 ] ; then pre=" "
  elif [ "${txt}" -ge 25 ] ; then pre=" "
  else                            pre=" "
  fi
  txt="${txt}"
  # Print string
  formatted_output
}

print_loop () {
  print_info || exit
  /usr/bin/acpi_listen | while read -r line ; do
    if echo "${line}" | grep --quiet --ignore-case 'brightness' ; then
      print_info
    fi
  done
}
