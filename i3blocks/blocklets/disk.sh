#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_bro}"
_icr=""
_ich=""
_rfs="$(df -hPl /      | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"
_hfs="$(df -hPl /home/ | tail -1 | awk '{ printf $3 "/" $2 " (" $5 ")" }' )"

echo "<span color=${_col}>${_icr}</span> ${_rfs} <span color=${_col}>${_ich}</span> ${_hfs}"
