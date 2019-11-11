#!/bin/sh

_NAME='Dropdown terminal'

spawn_terminal () {
    (
        flock 200
        /usr/bin/alacritty --title "${_NAME}" 2>&1 200>&- & disown
    ) 200>/var/tmp/dropdown-launch.lock
}

calculate_movement () {
    _NEW="$(bspc wm --dump-state | jq --compact-output '
        .focusedMonitorId as $mid | 
        .monitors[] |
        select(.id == $mid) |
        (.rectangle.height - .padding.bottom - .padding.top ) as $h |
        (.rectangle.width  - .padding.right  - .padding.left) as $w |
        (.rectangle.x + .padding.left) as $x |
        (.rectangle.y + .padding.top ) as $y |
        {
            x: ($x + (($w - ($w % 40)) / 40)) ,
            y: ($y) ,
            height: (($h - ($h % 3)) / 3) ,
            width: (($w - ($w % 20)) * 19 / 20)
        }')"
    _CUR="$(bspc query --node "$(xdotool search --name "${_NAME}")" --tree |
        jq --compact-output '.client.floatingRectangle')"
    echo "{\"current\": ${_CUR}, \"new\": ${_NEW}}" | jq '
        {
            origin:
            {
                dx: (.new.x - .current.x),
                dy: (.new.y - .current.y)
            },
            corner:
            {
                dx: (.new.width  - .current.width),
                dy: (.new.height - .current.height)
            }
        }'
}

#   Get window ID of dropdown terminal
#   If the dropdown window does not exist;
#       - Spawns a dropdown terminal
#       - Gets window ID of said terminal
_WID="$(xdotool search --name "${_NAME}")"
if [ -z "${_WID}" ] ; then
    spawn_terminal
    sleep .2
    _WID="$(xdotool search --name "${_NAME}")"
fi

#   If the window is hidden
#       - Reshape to the active monitor
#       - Toggle hidden state and focus
#   Else
#       - Hide window
if [ "$(bspc query --node "${_WID}" --tree | jq '.hidden')" = 'true' ] ; then
    # Get transformation
    _GEO="$(calculate_movement)"
    echo $_GEO | jq
    _OR_X="$(echo ${_GEO} | jq --raw-output '.origin.dx')"
    _OR_Y="$(echo ${_GEO} | jq --raw-output '.origin.dy')"
    _CO_X="$(echo ${_GEO} | jq --raw-output '.corner.dx')"
    _CO_Y="$(echo ${_GEO} | jq --raw-output '.corner.dy')"
    # Move the origin
    bspc node "${_WID}" --move   "${_OR_X}" "${_OR_Y}"
    bspc node "${_WID}" --resize bottom_right "${_CO_X}" "${_CO_Y}"
    # Toggle and focus
    bspc node "${_WID}" --flag hidden=off --focus
else
    bspc node "${_WID}" --flag hidden=on
fi
