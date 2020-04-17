#!/bin/dash

# Create parent directory
_loc=${HOME}/Pictures/Screenshots
mkdir -p "${_loc}"

# Get lexicographical date
_now="$(date +%Y-%m-%d_%H:%M:%S)"

if [ -z "$1" ] || [ "$1" = "--full" ]; then
    # Get a full screenshot
    _file="${_now}.png"
    # Clipboard copy
    if [ "$2" = "--clipboard" ] ; then
        grim - | wl-copy
        notify-send "Screenshot" "Full screenshot, copied to clipboard" -t 5000
    # Save to file
    else
        grim "${_loc}/${_file}"
        echo "Screenshot Full screenshot, saved at:\n${_file}"
        notify-send "Screenshot" "Full screenshot, saved at:\n${_file}" -t 5000 -i "${_loc}/${_file}"
    fi
elif [ "$1" = "--window" ] ; then
    # Get info of focused window
    _window="$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused and .pid)')"
    # Get name, for saving
    _name="$(echo "${_window}" | jq -r '.app_id')"
    # Get window geometry
    _geom="$(echo "${_window}" | jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"')"

    _file="${_now}-${_name}.png"
    # Copy to clipboard
    if [ "$2" = "--clipboard" ] ; then
        grim -g "${_geom}" - | wl-copy
        notify-send "Screenshot" "Active window screenshot,\ncopied to clipboard." -t 5000
    # Or write to file
    else
        grim -g "${_geom}" "${_loc}/${_file}"
        notify-send "Screenshot" "Active window screenshot, saved at\n${_file}" -t 5000 -i "${_loc}/${_file}"
    fi
elif [ "$1" = "--region" ] ; then
    # Get the box of desire
    _geom="$(slurp)"
    _file="${_now}-box.png"
    # Copy to clipboard
    if [ "$2" = "--clipboard" ] ; then
        grim -g "${_loc}/${_geom}" - | wl-copy
        notify-send "Screenshot" "Box ${_geom} screenshot,\ncopied to clipboard." -t 5000
    # Save file
    else
        grim -g "${_geom}" "${_loc}/${_file}"
        notify-send "Screenshot" "Box ${_geom} screenshot, saved at\n${_file}" -t 5000 -i "${_loc}/${_file}"
    fi
elif [ "$1" = "--colorpicker" ] ; then
    # Get the pixel
    _geom="$(slurp -p)"
    # Use imagemagick to extract data to text
    _out="$(grim -g "${_geom}" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-)"
    # Search text for hex strings
    _hex="$(echo "${_out}" | sed --silent 's|^.*\(#[a-f,A-F,0-9][a-f,A-F,0-9]*\).*$|\1|p')"
    # Copy to clipboard
    echo"${_hex}" | wl-copy
    # Pop notification
    notify-send "Color: ${_hex}" "${_hex} copied to clipboard" -t 30000
fi
