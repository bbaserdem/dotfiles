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
    *)      _col="${col_ind}" ;;
esac

_pri="$(curl -s http://api.coindesk.com/v1/bpi/currentprice.json | \
    jq -r '."bpi"."USD"."rate_float"')"

echo "${_pri} <span color=${_col}>ﴑ</span>"
