#!/usr/bin/bash

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
    *)      _col="${col_cya}" ;;
esac

echo "<span color=${_col}>$(if [ "$(pgrep openvpn)" ]; then echo ""; elif [ "$(pgrep openconnect)" ]; then echo "ﮂ"; else echo "</span><span color=${_mute}>廬"; fi;)</span>" | sed 's|&|&amp;|g'
