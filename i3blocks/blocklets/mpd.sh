#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_red}"
_len=32

# Pass the password in the block instance
if [[ -n $BLOCK_INSTANCE ]]; then
    _pass=("-h" "$BLOCK_INSTANCE@localhost")
fi

# On click actions
case $BLOCK_BUTTON in
    1) mpc $_pass toggle > /dev/null ;;  # left click, toggle
    3) $TERMINAL -e ncmpcpp & disown ;;     # Right click; lauch ncmpcpp
    4) mpc $_pass prev > /dev/null ;;    # scroll up, previous
    5) mpc $_pass next > /dev/null ;;    # scroll down, next
esac

# Prompt stuff
_text="$(mpc $_pass status | head -n 1)"
_icon="<span color=${_col}></span>"

[ "${#_text}" -gt "${_len}" ] && _text="${_text:0:${_len}}…"

if [ "$(mpc status | tail -n 2 | head -n 1 | awk '{ print $1 }')" == "[paused]" ]
then
    echo "${_icon} <span color=${_mute}>${_text}</span>" | sed 's|&|&amp;|g'
else
    echo "${_icon} ${_text}" | sed 's|&|&amp;|g'
fi
