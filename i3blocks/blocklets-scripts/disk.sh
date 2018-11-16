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
    *)      _col="${col_bro}" ;;
esac

_icr=""
_ich=""

_rfs="$(df -hPl /      | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"
_hfs="$(df -hPl /home/ | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"

echo "<span color=${_col}>${_icr}</span> ${_rfs} <span color=${_col}>${_ich}</span> ${_hfs}" | sed 's|&|&amp;|g'
