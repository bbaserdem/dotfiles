#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

###########################
#  _                   _  #
# | |_ ___ ___ ___ ___| | #
# | '_| -_|  _|   | -_| | #
# |_,_|___|_| |_|_|___|_| #
###########################
# Kernel module;

# Define these to override the do-nothing stuff
print_info () {
  # Example pre-amble
  txt="$(/usr/bin/uname --kernel-release)"
  pre=' '
  # Print string
  formatted_output
}

print_loop () {
  print_info
}
