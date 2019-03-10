#!/bin/sh

id=$(xdo id -a dropdown);
if [ -z "$id" ]; then
    /usr/bin/termite --title 'dropdown'
else
    if [[ $(xprop -id $id|awk '/window state: / {print $3}') == 'Withdrawn' ]]
    then
        action='show'
    else
        action='hide'
    fi
    xdo $action -a dropdown
fi
