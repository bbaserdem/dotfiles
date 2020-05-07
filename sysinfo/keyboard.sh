#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT


#####################################
#  _           _                 _  #
# | |_ ___ _ _| |_ ___ ___ ___ _| | #
# | '_| -_| | | . | . | .'|  _| . | #
# |_,_|___|_  |___|___|__,|_| |___| #
#         |___|                     #
#####################################
# Keyboard module
click_left () {
  if [ "${XDG_SESSION_TYPE}" = 'x11' ] ; then
    if [ -x '/usr/bin/xkb-switch' ] ; then
      /usr/bin/xkb-switch --next
    fi
  elif [ -n "${SWAYSOCK}" ] ; then
    true
  fi
}
scroll_up () {
  if [ -x '/usr/bin/light' ] ; then
    device="$(/usr/bin/light -L 2>/dev/null | awk '/kbd_backlight/ {print $1}')"
    if [ -n "${device}" ] ; then
      /usr/bin/light -Ars "${device}" 1
    fi
  fi
}
scroll_down () {
  if [ -x '/usr/bin/light' ] ; then
    device="$(/usr/bin/light -L 2>/dev/null | awk '/kbd_backlight/ {print $1}')"
    if [ -n "${device}" ] ; then
      /usr/bin/light -Urs "${device}" 1
    fi
  fi
}
print_info () {
  # Initialize
  pre=' '
  # Different protocols for different software
  if [ "${XDG_SESSION_TYPE}" = 'x11' ] ; then
    # Get keymap
    state="$(xkb-switch --print)"
  elif [ -n "${SWAYSOCK}" ] ; then
    state="$(/usr/bin/swaymsg --type get_inputs | jq '.[] | 
      select(.name | test(".*[K,k]eyboard.*")) | select(.type == "keyboard") |
      .xkb_active_layout_name' | tail -n 1)"
  else
    empty_output
    exit 1
  fi
  # Seperate language and layout
  lang="$(echo "${state}"   | awk -F '[ ()]' '{print $1}')"
  layout="$(echo "${state}" | awk -F '[ ()]' '{print $2}')"
  # Start laying out text (with emoji if possible)
  if [ "${markup}" != 'lemonbar' ] ; then
    case "${lang}" in
      us) txt='🇺🇸' ;;
      tr) txt='🇹🇷' ;;
      *)  txt="$(echo "${lang}" | awk '{print toupper($0)}')"
    esac
  else
    case "${lang}" in
      us) txt='US' ;;
      tr) txt='TR' ;;
      *)  txt="$(echo "${lang}" | awk '{print toupper($0)}')"
    esac
  fi
  # Add the layout
  if [ -n "${layout}" ] ; then
    txt="${txt}(${layout})"
  else
    txt="${txt}(qwerty)"
  fi
  # Get the keyboard backlight if it is there
  if [ -x '/usr/bin/light' ] ; then
    device="$(/usr/bin/light -L 2>/dev/null | awk '/kbd_backlight/ {print $1}')"
    if [ -n "${device}" ] ; then
      blevel="$(/usr/bin/light -Gs "${device}" | awk '{printf("%d", $1)}')"
      if   [ "${blevel}" -gt 66 ] ; then suf=" "
      elif [ "${blevel}" -gt 33 ] ; then suf=" "
      elif [ "${blevel}" -gt  0 ] ; then suf=" "
      fi
    fi
  fi
  # Print string
  formatted_output
}

print_loop () {
  # Check if kbd_backlight device exists to wait for changes
  kbdlight_wait() {
    if [ -x '/usr/bin/light' ] && [ -x '/usr/bin/acpi_listen' ] ; then
      device="$(/usr/bin/light -L 2>/dev/null | awk '/kbd_backlight/ {print $1}')"
      if [ -n "${device}" ] ; then
        /usr/bin/acpi_listen | while read -r event ; do
          if echo "${event}" | grep --quiet 'kbd' ; then
            print_info
          fi
        done
      else
        exit
      fi
    fi
  }
  # Check if kbd_backlight device exists to wait for it
  keymap_wait() {
    if [ "${XDG_SESSION_TYPE}" = 'x11' ] && [ -x '/usr/bin/xkb-switch' ] ; then
      /usr/bin/xkb-switch -W | while read -r line ; do
        print_info
      done
    elif [ -n "${SWAYSOCK}" ] ; then
      /usr/bin/swaymsg --type subscribe '["input"]' --monitor | while read -r line ; do
        if [ "$(echo "${line}" | jq '.change' --raw)" = 'xkb_layout' ] ; then
          print_info
        fi
      done
    else
      exit
    fi
  }
  print_info
  kbdlight_wait &
  keymap_wait
}
