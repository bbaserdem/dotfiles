#!/bin/dash
# vim:ft=sh
# Script to change pulseaudio sink

# Change default sink; and move all inputs to the new sink
_info="$(/usr/bin/pacmd 'list-sinks')"
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
/usr/bin/pacmd 'set-default-sink' "${_dnew}"
# Switch all inputs here
_inputs="$(/usr/bin/pacmd 'list-sink-inputs')"
_iindex="$(echo "${_inputs}" | awk '/index:/ {print $2}')"
_iflags="$(echo "${_inputs}" | grep 'flags:')"
_i=1
while [ "${_i}" -le "$(echo "${_iindex}" | wc --lines)" ] ; do
  _ind="$(echo "${_iindex}" | sed --quiet "${_i}p")"
  _fla="$(echo "${_iflags}" | sed --quiet "${_i}p")"
  # Don't move if the DONT_MOVE flag is on
  if echo "${_fla}" | grep --invert-match --quiet 'DONT_MOVE' ; then
    /usr/bin/pacmd 'move-sink-input' "${_ind}" "${_dnew}"
  fi
  _i="$(( _i + 1 ))"
done
