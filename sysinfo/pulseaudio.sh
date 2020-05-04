#!/bin/dash
# vim:ft=sh

# Kill all descendents on exit
trap 'exit' INT TERM
trap 'kill 0' EXIT

#########################################
#          _                   _ _      #
#  ___ _ _| |___ ___ ___ _ _ _| |_|___  #
# | . | | | |_ -| -_| .'| | | . | | . | #
# |  _|___|_|___|___|__,|___|___|_|___| #
# |_|                                   #
#########################################
# Pulseaudio module;
#  * Only needs pacmd (pulseaudion) and pactl (libpulse)
#  * Needs a instance of either 'sink' or 'source'
if [ -z "${instance}" ] || [ "${instance}" = 'default' ] ; then
  instance='sink'
fi
click_left () { # Left click action
  # Toggle mute
  /usr/bin/pactl "set-${instance}-mute" \
    "@DEFAULT_$(echo ${instance} | awk '{print toupper($0)}')@" toggle
}
click_middle () { # Middle mouse action
  if [ "${instance}" = 'source' ] ; then
    _cmd='source-output'
  elif [ "${instance}" = 'sink' ] ; then
    _cmd='sink-input'
  fi
  # Change default sink; and move all inputs to the new sink
  _info="$(/usr/bin/pacmd "list-${instance}s")"
  _ndev="$(echo "${_info}" | grep --count 'index:')"
  _inds="$(echo "${_info}" | grep 'index:' | grep --only-matching '[0-9]\+')"
  # Get default sink
  _icur="$(echo "${_info}" | grep 'index:' \
    | grep --line-number --only-matching '*' \
    | grep --only-matching '[0-9]\+')"
  # Get the next sink
  _inew="$(( ( _icur % _ndev ) + 1 ))"
  _dnew="$(echo "${_inds}" | sed --quiet "${_inew}p")"
  # Switch to this default
  /usr/bin/pacmd "set-default-${instance}" "${_dnew}"
  # Switch all inputs here
  _inputs="$(/usr/bin/pacmd "list-${_cmd}s")"
  _iindex="$(echo "${_inputs}" | awk '/index:/ {print $2}')"
  _iflags="$(echo "${_inputs}" | grep 'flags:')"
  _i=1
  while [ "${_i}" -le "$(echo "${_iindex}" | wc --lines)" ] ; do
    _ind="$(echo "${_iindex}" | sed --quiet "${_i}p")"
    _fla="$(echo "${_iflags}" | sed --quiet "${_i}p")"
    # Don't move if the DONT_MOVE flag is on
    if echo "${_fla}" | grep --invert-match --quiet 'DONT_MOVE' ; then
      /usr/bin/pacmd "move-${_cmd}" "${_ind}" "${_dnew}"
    fi
    _i="$(( _i + 1 ))"
  done
}
click_right () { # Right mouse action
  ( flock --nonblock 7 || exit 7
    if [ -x '/usr/bin/pavucontrol' ] ; then
      /usr/bin/pavucontrol
    fi
  ) 7>"${SYSINFO_FLOCK_DIR}/${name}_${IDENTIFIER}_right" >/dev/null 2>&1 &
}
scroll_up () { # Scroll up action
  if [ "${instance}" = 'source' ] ; then
    _cap='Source'
    _def='@DEFAULT_SOURCE@'
  elif [ "${instance}" = 'sink' ] ; then
    _cap='Sink'
    _def='@DEFAULT_SINK@'
  fi
  # Increase volume if the default sink volume is >100%
  # Default sink
  _d_sink="$(/usr/bin/pactl info | awk -F ': ' "/Default ${_cap}/ {print \$2}")"
  _d_lnum="$(/usr/bin/pactl list "${instance}s" short \
    | grep --line-number "${_d_sink}" | cut --delimiter ':' --fields '1')"
  # Volume of default sink
  _vol="$(/usr/bin/pactl list "${instance}s" | awk '/^\sVolume/ {vol=0; n=0;
    for (i = 1; i <= NF; i++) {
      if( substr($i, length($i), 1) == "%" ) {
        vol += substr($i, 1, length($i) - 1); n++; }
      } printf("%.0f\n", vol/n);}' | sed --quiet "${_d_lnum}p")"
  if [ "${_vol}" -lt 100 ] ; then
    /usr/bin/pactl "set-${instance}-volume" "${_def}" +1%
  else
    /usr/bin/pactl "set-${instance}-volume" "${_def}" 100%
  fi
}
scroll_down () { # Scroll down action
  # Launch and disown pavucontrol
  /usr/bin/pactl "set-${instance}-volume" \
    "@DEFAULT_$(echo "${instance}" | awk '{print toupper($0)}')@" -1%
}
print_info () {
  feature=''
  if [ "${instance}" = 'sink' ] ; then 
    # Get pulseaudio state info
    pinfo="$(/usr/bin/pactl info)"
    sinks="$(/usr/bin/pactl list "${instance}s")"
    ssink="$(/usr/bin/pactl list "${instance}s" short)"
    ports="$(echo "${sinks}" | awk -F ': ' \
      '/Active Port/ {print $2}')"
    muted="$(echo "${sinks}" | awk -F ': ' \
      '/Mute/ {print $2}')"
    volms="$(echo "${sinks}" | awk '/^\sVolume/ {vol=0; n=0;
      for (i = 1; i <= NF; i++) {
        if( substr($i, length($i), 1) == "%" ) {
          vol += substr($i, 1, length($i) - 1); n++; }
        } printf("%.0f\n", vol/n);}')"
    sicon="$(echo "${sinks}" | awk -F ' = ' \
      '/device.icon_name/ {print substr($2, 2, length($2) - 2)}')"
    # Get information about the default sink
    d_sink="$(echo "${pinfo}" | awk -F ': ' '/Default Sink/ {print $2}')"
    d_lnum="$(echo "${ssink}" | grep --line-number "${d_sink}" \
      | cut --delimiter ':' --fields '1')"
    d_port="$(echo "${ports}" | sed --quiet "${d_lnum}p")"
    d_mute="$(echo "${muted}" | sed --quiet "${d_lnum}p")"
    d_volm="$(echo "${volms}" | sed --quiet "${d_lnum}p")"
    d_icon="$(echo "${sicon}" | sed --quiet "${d_lnum}p")"
    # Determine icon for the sink
    case "${d_icon}" in
      *hdmi*)                                         pre="﴿ " ;;
      *headset*)            [ "${d_mute}" = 'no' ] && pre=" "  || pre=" "  ;;
      *a2dp*)               [ "${d_mute}" = 'no' ] && pre="﫽 " || pre="﫾 " ;;
      *hifi*|*stereo*)                                pre="﫛 " ;;
      *headphone*|*lineout*)[ "${d_mute}" = 'no' ] && pre=" "  || pre="ﳌ "  ;;
      *speaker*)            [ "${d_mute}" = 'no' ] && pre="蓼 " || pre="遼 " ;;
      *network*)                                      pre="爵 " ;;
      *)                    [ "${d_mute}" = 'no' ] && pre="墳 " || pre="ﱝ "  ;;
    esac
    # Check if it's a bluetooth sink, adjust suffix
    if echo "${d_sink}" | grep -q 'bluez' ; then
      suf=' '
    else
      suf=''
    fi
  elif [ "${instance}" = 'source' ] ; then 
    # Get pulseaudio state info
    pinfo="$(/usr/bin/pactl info)"
    srces="$(/usr/bin/pactl list "${instance}s")"
    ssrcs="$(/usr/bin/pactl list "${instance}s" short)"
    # Get device.icon_name field
    iconn="$(echo "${srces}" | awk -F ' = ' \
      '/device.icon_name/ {print substr($2, 2, length($2) - 2)}')"
    muted="$(echo "${srces}" | awk -F ': ' \
      '/Mute/ {print $2}')"
    volms="$(echo "${srces}" | awk '/^\sVolume/ {vol=0; n=0;
      for (i = 1; i <= NF; i++) {
        if( substr($i, length($i), 1) == "%" ) {
          vol += substr($i, 1, length($i) - 1); n++; }
        } printf("%.0f\n", vol/n);}')"
    # Get information about the default sink
    d_src="$(echo "${pinfo}" | awk -F ': ' '/Default Source/ {print $2}')"
    d_lno="$(echo "${ssrcs}" | grep --line-number "${d_src}" \
      | cut --delimiter ':' --fields '1')"
    d_icon="$(echo "${iconn}" | sed --quiet "${d_lno}p")"
    d_mute="$(echo "${muted}" | sed --quiet "${d_lno}p")"
    d_volm="$(echo "${volms}" | sed --quiet "${d_lno}p")"
    # Determine icon for the sink
    case "${d_icon}" in
      audio-card-pci) [ "${d_mute}" = 'no' ] && pre=" "  || pre=" " ;;
      camera-web-usb)                           pre="犯 " ;;
      *)              [ "${d_mute}" = 'no' ] && pre=" "  || pre=" " ;;
    esac
    # Check if it's a bluetooth source
    if echo "${d_src}" | grep -q 'bluez' ; then
      suf=' '
    else
      suf=''
    fi
  else
    empty_output
    exit 1
  fi
  txt="${d_volm}"
  if [ "${d_mute}" = 'yes' ] ; then
    feature='mute'
  fi
  # Print string
  formatted_output
}
print_loop () {
  # Print once
  print_info || exit
  /usr/bin/pactl subscribe 2>/dev/null | while read -r _line ; do
    if echo "${_line}" \
      | grep --quiet --ignore-case "${instance}\|'change' on server #" ; then
      print_info
    fi
  done
}
