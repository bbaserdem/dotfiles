#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_bro}"
_ico=""
_len=52
_txt="$(khal list | head -n 1)"
[ "${#_txt}" -gt "${_len}" ] && _txt="${_txt:0:${_len}}…"
[ "${_txt}" = "No events" ]  && _txt="<span color=${_mute}>${_txt}</span>"
echo "<span color=${_col}>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g'
