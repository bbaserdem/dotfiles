#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_gre}"
_ico=""
_num="$(newsboat -x print-unread | awk '{ print $1 }')"
[ "${_num}" == "Error:" ] && _num="<span color=${_mute}></span>"
echo "<span color=${_col}>${_ico}</span> ${_num}" | sed 's|&|&amp;|g'
