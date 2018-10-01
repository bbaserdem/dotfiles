#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh


_col="${col_ora}"
_ico=""
function join_by { local IFS="$1"; shift; echo "$*"; }
_spe="$(sensors | grep 'Fan' | awk '{print $3}' | tr '\n' ',')"
_spe="${_spe::-1}"

[ "$_spe" != "" ] && \
    echo "<span color=${_col}>${_ico}</span> ${_spe}" | sed 's|&|&amp;|g'
