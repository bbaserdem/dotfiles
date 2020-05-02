#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#######################
#      _         _    #
#  ___| |___ ___| |_  #
# |  _| | . |  _| '_| #
# |___|_|___|___|_,_| #
#######################
# Clock module;
#  * Takes no arguments

print_info () {
  # Example pre-amble
  suf=''
  feature=''
  # Change icon depending on the hour
  hour="$(date '+%H')"
  if   [ "${hour}" = '00' ] || [ "${hour}" = '12' ] ; then pre=" "
  elif [ "${hour}" = '01' ] || [ "${hour}" = '13' ] ; then pre=" "
  elif [ "${hour}" = '02' ] || [ "${hour}" = '14' ] ; then pre=" "
  elif [ "${hour}" = '03' ] || [ "${hour}" = '15' ] ; then pre=" "
  elif [ "${hour}" = '04' ] || [ "${hour}" = '16' ] ; then pre=" "
  elif [ "${hour}" = '05' ] || [ "${hour}" = '17' ] ; then pre=" "
  elif [ "${hour}" = '06' ] || [ "${hour}" = '18' ] ; then pre=" "
  elif [ "${hour}" = '07' ] || [ "${hour}" = '19' ] ; then pre=" "
  elif [ "${hour}" = '08' ] || [ "${hour}" = '20' ] ; then pre=" "
  elif [ "${hour}" = '09' ] || [ "${hour}" = '21' ] ; then pre=" "
  elif [ "${hour}" = '10' ] || [ "${hour}" = '22' ] ; then pre=" "
  elif [ "${hour}" = '11' ] || [ "${hour}" = '23' ] ; then pre=" "
  else pre=" "
  fi
  txt="$(date '+%H:%M')"
  # Print string
  formatted_output
}
print_loop () {
  # Poll the time every minute, starting from the start of every minute
  print_info
  # The first wait should be until the end of the current minute
  sleep "$(( 1 + 60 - $(date '+%S') ))"
  while : ; do
    print_info
    sleep 60
  done
}
