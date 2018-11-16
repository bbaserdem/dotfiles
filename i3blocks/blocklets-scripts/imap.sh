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
    *)      _col="${col_yel}" ;;
esac

_file="${HOME}/Documents/Mail/Gmail/Inbox/new"

get_text () {
    _new="$(find $HOME/Documents/Mail/Gmail/Inbox/new | wc -l)"
    if [ "$_new" -le 0 ] ; then
        _ico=""
        _new=""
    else
        _ico=""
        _new=" ${_new}"
    fi
    echo "<span color=${_col}>${_ico}</span>${_new}" | sed 's|&|&amp;|g'
}

text_loop () {
    while : ; do
        get_text
        sleep 5
        inotifywait --timeout -1 --recursive "${_file}" > /dev/null 2>&1 || break
    done
}

text_loop
