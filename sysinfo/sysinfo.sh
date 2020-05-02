#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#------------------------------------#
#  _____           _        __       #
# /  ___|         (_)      / _|      #
# \ `--. _   _ ___ _ _ __ | |_ ___   #
#  `--. \ | | / __| | '_ \|  _/ _ \  #
# /\__/ / |_| \__ \ | | | | || (_) | #
# \____/ \__, |___/_|_| |_|_| \___/  #
#         __/ |                      #
#        |___/                       #
#------------------------------------#
# Script(s) to print system information in a variety of formats.
help_text="Usage: sysinfo.sh [-m <text>] -n <text> [-i <text>] [-a <text>] [-b BUTTON] [-h] -t
Continuously print system information
        -b <text>  Button click to simulate (does not do text; exits)
        -h         Display this help text and exit
        -t         Test the script; do not loop indefinitely
        (The following can be defined using environment vars)
        -m <text>  Set [markup] type (default is lemonbar)
        -n <text>  Module [name]
        -i <text>  Module [instance]
        -a <text>  Color for [accent]ing"
clicksim=''
testing='no'
while getopts "b:h:m:n:i:a:t" option; do
  case "${option}" in
    b) clicksim="${OPTARG}" ;;
    h) echo "${help_text}" ; exit ;;
    m) markup="${OPTARG}" ;;
    n) name="${OPTARG}" ;;
    i) instance="${OPTARG}" ;;
    a) accent="${OPTARG}" ;;
    t) testing='yes' ;;
    ?) echo "${help_text}" ; exit 1 ;;
  esac
done

#---DEFAULTS---#
#   - markup:   Decides how the text are going to be formatted
if [ -z "${markup}" ] ;   then markup='lemonbar'  ; fi
#   - name:     The module to launch
if [ -z "${name}" ] ;     then name='mpd'         ; fi
#   - instance: Additional argument to the module
if [ -z "${instance}" ] ; then instance='default' ; fi
#   - accent:   The color to apply to special characters
if [ -z "${accent}" ] ;   then accent='cyan'      ; fi
# Location for flocks; try sane defaults
if [ -z "${SYSINFO_FLOCK_DIR}" ] ; then
  if [ -n "${XDG_CACHE_HOME}" ] ; then
    SYSINFO_FLOCK_DIR="${XDG_CACHE_HOME}/sysinfo"
  else
    SYSINFO_FLOCK_DIR="${HOME}/.cache/sysinfo"
  fi
fi
# Create file lock directory
if [ ! -e "${SYSINFO_FLOCK_DIR}" ] ; then
  mkdir --parents "${SYSINFO_FLOCK_DIR}"
elif [ ! -d "${SYSINFO_FLOCK_DIR}" ] ; then
  exit 1
fi
# Initialize these, just in case
pre=''
suf=''
feature=''
txt=''

#---IDENTIFIER---#
# Get a session identifier both for xorg and wayland
if [ -n "${WAYLAND_DISPLAY}" ] ; then
  IDENTIFIER="${WAYLAND_DISPLAY}"
elif [ -n "${DISPLAY}" ] ; then
  IDENTIFIER="${DISPLAY}"
else
  IDENTIFIER="$$"
fi

#---COLORS---#
# If there are no base16 set defined in environment; do base16-default-dark
if [ -z "${base00}" ] ; then base00='#181818' ; fi
if [ -z "${base01}" ] ; then base01='#282828' ; fi
if [ -z "${base02}" ] ; then base02='#383838' ; fi
if [ -z "${base03}" ] ; then base03='#585858' ; fi
if [ -z "${base04}" ] ; then base04='#b8b8b8' ; fi
if [ -z "${base05}" ] ; then base05='#d8d8d8' ; fi
if [ -z "${base06}" ] ; then base06='#e8e8e8' ; fi
if [ -z "${base07}" ] ; then base07='#f8f8f8' ; fi
if [ -z "${base08}" ] ; then base08='#ab4642' ; fi
if [ -z "${base09}" ] ; then base09='#dc9656' ; fi
if [ -z "${base0A}" ] ; then base0A='#f7ca88' ; fi
if [ -z "${base0B}" ] ; then base0B='#a1b56c' ; fi
if [ -z "${base0C}" ] ; then base0C='#86c1b9' ; fi
if [ -z "${base0D}" ] ; then base0D='#7cafc2' ; fi
if [ -z "${base0E}" ] ; then base0E='#ba8baf' ; fi
if [ -z "${base0F}" ] ; then base0F='#a16946' ; fi
# Dimming color is base03, and urgent color is base09
dim="${base03}"
urg="${base09}"
# Read accent color; and write it into the variable col
if   [ "${accent}" = 'frg' ]    ; then col="${base04}"
elif [ "${accent}" = 'bkg' ]    ; then col="${base01}"
elif [ "${accent}" = 'dim' ]    ; then col="${base03}"
elif [ "${accent}" = 'red' ]    ; then col="${base08}"
elif [ "${accent}" = 'orange' ] ; then col="${base09}"
elif [ "${accent}" = 'yellow' ] ; then col="${base0A}"
elif [ "${accent}" = 'green' ]  ; then col="${base0B}"
elif [ "${accent}" = 'cyan' ]   ; then col="${base0C}"
elif [ "${accent}" = 'indigo' ] ; then col="${base0D}"
elif [ "${accent}" = 'violet' ] ; then col="${base0E}"
elif [ "${accent}" = 'brown' ]  ; then col="${base0F}"
else # Invalid accent specification
  exit 1
fi

#---FUNCTIONS---#
# Shortcut to suppress module
empty_output () {
  # Remove a module from display
  if [ "${markup}" = 'lemonbar' ] ; then
    # Format by lemonbar tags
    echo ""
  elif [ "${markup}" = 'pango' ] ; then
    # Create pango formatted string
    echo "{\"full_text\":\"\"}"
  fi
}
formatted_output () {
  # Print string
  if [ -z "${txt}" ] ; then
    empty_output
  elif [ "${markup}" = 'lemonbar' ] ; then
    # Format by lemonbar tags
    if [ -z "${feature}" ] ; then
      out="%{F${col}}${pre}%{F-}${txt}%{F${col}}${suf}%{F-}"
    elif [ "${feature}" = 'mute' ] ; then
      out="%{F${col}}${pre}%{F-}%{F${dim}}${txt}%{F-}%{F${col}}${suf}%{F-}"
    elif [ "${feature}" = 'urgent' ] ; then
      out="%{F${col}}${pre}%{F-}%{F${urg}}${txt}%{F-}%{F${col}}${suf}%{F-}"
    fi
    echo "%{u${col} +u o${col} +o}${out}%{-u u- -o o-}"
  elif [ "${markup}" = 'pango' ] ; then
    # Create pango formatted string
    out="$(echo "${txt}" | sed 's|&|&amp;|g ; s|<|&lt;|g')"
    out="<span color='${col}'>${pre}</span>${out}<span color='${col}'>${suf}</span>"
    if [ -z "${feature}" ] ; then
      echo "{\"full_text\":\"${out}\"}"
    elif [ "${feature}" = 'mute' ] ; then
      echo "{\"full_text\":\"${out}\",\"color\":\"${dim}\"}"
    elif [ "${feature}" = 'urgent' ] ; then
      echo "{\"full_text\":\"${out}\",\"urgent\":true}"
    fi
  fi
}
# Default to taking no actions
click_left ()   { true ; }
click_middle () { true ; }
click_right ()  { true ; }
scroll_up ()    { true ; }
scroll_down ()  { true ; }

#---MODULE---#
# Import the module from directories
if [ -x "$(dirname "${0}")/${name}.sh" ] ; then
  # shellcheck source=module.sh
  . "$(dirname "${0}")/${name}.sh"
else
  echo "No module ${name} found in $(dirname "${0}")!"
  exit 1
fi

#---EMULATE CLICKS---#
if [ -n "${clicksim}" ] ; then
  "${clicksim}"
  exit
fi

#---OUTPUT---#
# Run the waiter loops if the module exists
if [ "${testing}" = 'no' ] ; then
  if type "print_loop" 2>/dev/null | grep --quiet 'function' ; then
    print_loop &
  else
    echo "print_loop for ${name} is not available!"
    exit 1
  fi
elif [ "${testing}" = 'yes' ] ; then
  print_info
  exit
fi

#---LISTENING---#
# Responde to inputs
while read -r input_button ; do
  case "$(echo "${input_button}" | jq --raw-output '.button')" in
    1) "click_left"   || continue ;;
    2) "click_middle" || continue ;;
    3) "click_right"  || continue ;;
    4) "scroll_up"    || continue ;;
    5) "scroll_down"  || continue ;;
    *) true ;;
  esac
done
