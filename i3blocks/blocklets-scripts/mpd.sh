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
    *)      _col="${col_red}" ;;
esac

_len=32

# Pass the password in the block instance
if [[ -n $BLOCK_INSTANCE ]]; then
    _pass=("-h" "$BLOCK_INSTANCE@localhost")
fi

get_text () {
    # Prompt stuff
    _text="$(mpc $_pass status | head -n 1)"
    _icon="<span color=${_col}></span>"

    [ "${#_text}" -gt "${_len}" ] && _text="${_text:0:${_len}}…"

    _pre="$(mpc $_pass status | tail -n 2 | head -n 1 | awk '{print $1}')"
    if [ "${_text}" == "" ] ; then
        echo "${_icon} <span color=${_mute}>--</span>" | sed 's|&|&amp;|g'
    elif [ "${_pre}" == "[paused]" ] ; then
        echo "${_icon} <span color=${_mute}>${_text}</span>" | sed 's|&|&amp;|g'
    elif [[ $_pre == volume:* ]] ; then
        echo "${_icon} <span color=${_mute}>Empty playlist…</span>" | sed 's|&|&amp;|g'
    elif [ "${_pre}" == "Updating" ] ; then
        echo "${_icon} <span color=${_mute}>DB Update…</span>" | sed 's|&|&amp;|g'
    else
        echo "${_icon} ${_text}" | sed 's|&|&amp;|g'
    fi
}

text_loop () {
    while : ; do
        get_text
        sleep .2
        mpc idle > /dev/null || sleep 60
    done
}

text_loop &

# On click actions
while read button ; do
    case $button in
        1) mpc $_pass toggle > /dev/null ;;  # left click, toggle
        4) mpc $_pass prev > /dev/null ;;    # scroll up, previous
        5) mpc $_pass next > /dev/null ;;    # scroll down, next
    esac
done
