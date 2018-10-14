#!/bin/sh

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
    *)      _col="${col_ind}" ;;
esac

_ico=""

case $BLOCK_BUTTON in
    1)  # I have given permission for wheel to run this command
        sudo /bin/systemctl start pacman-update.service ;;
esac

_upd="$(checkupdates | wc -l)"
echo "<span color=${_col}>${_ico}</span> ${_upd}" | sed 's|&|&amp;|g'
