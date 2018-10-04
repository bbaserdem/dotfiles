#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_vio}"
_ico=""

_sta="$(xkb-switch -p)"
_lan="$(echo "${_sta}" | sed 's|\(.*\)(.*)|\1|' | awk '{print toupper($0)}')"
_lay="$(echo "${_sta}" | grep '(' | sed 's|.*(\(.*\))|\1|')"
[ -z "${_lay}" ] && _lay="qwe" || _lay="${_lay:0:3}"

echo "<span color=${_col}>${_ico}</span> ${_lan}(${_lay})" | sed 's|&|&amp;|g'
