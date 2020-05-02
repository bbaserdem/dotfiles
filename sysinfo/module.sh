#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

############################################################
#                        _                    _     _      #
#  ___ _ _ ___ _____ ___| |___    _____ ___ _| |_ _| |___  #
# | -_|_'_| .'|     | . | | -_|  |     | . | . | | | | -_| #
# |___|_,_|__,|_|_|_|  _|_|___|  |_|_|_|___|___|___|_|___| #
#                   |_|                                    #
############################################################
# Ascii generator: http://patorjk.com/software/taag/#p=display&f=Rectangles
# Ascii theme: Rectangles
# Example module to use as template

# Define these to override the do-nothing stuff
click_left ()   { true ; }
click_middle () { true ; }
click_right ()  { true ; }
scroll_up ()    { true ; }
scroll_down ()  { true ; }
print_info () {
  # Example pre-amble
  pre=''
  suf=''
  txt='Example text'
  feature=''
  # Print string
  formatted_output
}

print_loop () {
  while : ; do
    print_info || break
    sleep 1
  done
}
