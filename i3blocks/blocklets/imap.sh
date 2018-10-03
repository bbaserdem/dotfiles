#!/usr/bin/sh

. ${XDG_CONFIG_HOME}/i3blocks/colors.sh

_col="${col_yel}"
_new="$(find $HOME/Documents/Mail/Gmail/Inbox/new | wc -l)"

if [ "$_new" -le 0 ]
then
    _ico=""
    _new=""
else
    _ico=""
fi

echo '<span color='"$_col"'>'"$_ico"'</span> '"$_new" | sed 's|&|&amp;|g'
