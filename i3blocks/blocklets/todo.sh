#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_bro}"
_ico="省"
_len=32
_jso="$(todo --porcelain list --sort priority)"
_txt="$(echo "${_jso}" | jq -r '.[0]."summary"')"
[ "${_txt}" = "null" ] && _txt="<span color=${_mute}>No tasks</span>"
echo "<span color=${_col}>${_ico}</span> ${_txt}" | sed 's|&|&amp;|g'
