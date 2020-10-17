#!/bin/dash
# vim:ft=sh
# Script to change pulseaudio sink

rev='no'
instance='sink'
cmd='sink-input'
while getopts "r:s" option; do
  case "${option}" in
    r) rev='yes' ;;
    s) instance='source' ; cmd='source-output' ;;
    ?) exit 1 ;;
  esac
done

# Change default sink; and move all inputs to the new sink
_info="$(/usr/bin/pacmd "list-${instance}s")"
_ndev="$(echo "${_info}" | grep --count 'index:')"
_inds="$(echo "${_info}" | grep 'index:' | grep --only-matching '[0-9]\+')"
# Get default sink
_icur="$(echo "${_info}" | grep 'index:' \
  | grep --line-number --only-matching '*' \
  | grep --only-matching '[0-9]\+')"
# Get the next sink
if [ "${rev}" = 'no' ]; then
  _inew="$(( ( _icur % _ndev ) + 1 ))"
elif [ "${rev}" = 'yes' ]; then
  _inew="$(( ( ( _icur - 2 + _ndev ) % _ndev ) + 1 ))"
fi
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
