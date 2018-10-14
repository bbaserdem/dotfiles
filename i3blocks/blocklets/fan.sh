#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh
# Get color
_col="${1}"
case "$_col" in
    red)    _col="${col_red}" ;;
    orange) _col="${col_ora}" ;;
    yellow) _col="${col_yel}" ;;
    green)  _col="${col_gre}" ;;
    cyan)   _col="${col_cya}" ;;
    indigo) _col="${col_ind}" ;;
    violet) _col="${col_vio}" ;;
    brown)  _col="${col_bro}" ;;
    *)      _col="${col_ora}" ;;
esac

_ico=""
function join_by { local IFS="$1"; shift; echo "$*"; }
_spe="$(sensors | grep 'Fan' | awk '{print $3}' | tr '\n' ',')"
_spe="${_spe::-1}"

[ "$_spe" != "" ] && \
    echo "<span color=${_col}>${_ico}</span> ${_spe}" | sed 's|&|&amp;|g'
