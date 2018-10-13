#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh
# Get color
_col="${1}"
case $_col in
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

_int=${BLOCK_INSTANCE:-ethernet}
_ico=""

[[ ! -d /sys/class/net/${_int} ]] && exit
[[ "$(cat /sys/class/net/${_int}/operstate)" = 'down' ]] && exit

# Get IP address
_ipa="$(/usr/bin/ip -o -4 addr list ${_int} | awk '{print $4}' | cut -d/ -f1)"

echo "<span color=${_col}>${_ico}</span> ${_ipa}" | sed 's|&|&amp;|g'
