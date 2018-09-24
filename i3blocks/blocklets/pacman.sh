#!/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_ind}"
_ico=""

case $BLOCK_BUTTON in
    1)  # I have given permission for wheel to run this command
        sudo /bin/systemctl start pacman-update.service ;;
esac

_upd="$(checkupdates | wc -l)"
echo "<span color=${_col}>${_ico}</span> ${_upd}" | sed 's|&|&amp;|g'
