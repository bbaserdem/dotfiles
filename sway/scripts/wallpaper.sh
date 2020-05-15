#!/bin/dash
# Script to change wallpaper of all running sway instances
info="$(swaymsg -t get_outputs --raw)"
name="$(echo "${info}" | jq --raw-output '.[] | .name')"

# Get the rectangle edge info
x_end="$(echo "${info}" | jq '.[] | .rect | (.x + .width)')"
y_end="$(echo "${info}" | jq '.[] | .rect | (.y + .height)')"

# Get the full size
x_max="$(echo "${x_end}" | sort | tail -n 1)"
y_max="$(echo "${y_end}" | sort | tail -n 1)"
dimmax="${x_max}x${y_max}"

# Set a theme
theme=''
if [ -n "${1}" ] && [ ! -d "${1}" ] ; then
    theme="${1}"
elif [ -n "${2}" ] ; then
    theme="${2}"
fi

imfind_dir () {
    find "$1" -type f -a '(' \
      -iname "${theme}*.jpg"  -o \
      -iname "${theme}*.jpeg" -o \
      -iname "${theme}*.png" ')' -print 2>/dev/null \
      | shuf -n 1 -
}
# Try to find image; if a dir is specified
if [ -n "${SBP_WPAPER_DIR}" ] && [ -d "${SBP_WPAPER_DIR}" ]; then
    if [ -d "${SBP_WPAPER_DIR}/${dimmax}" ] ; then
        wallp="$(imfind_dir "${SBP_WPAPER_DIR}/${dimmax}")"
    else
        wallp="$(imfind_dir "${SBP_WPAPER_DIR}")"
    fi
# If the dir is not specified; try to find one in other locations
else
    # Check if a directory was given as a positional argument
    if [ -n "${1}" ] && [ -d "${1}" ] ; then
        wallp="$(imfind_dir "${1}")"
    elif [ -d '/usr/share/backgrounds' ] ; then
        wallp="$(imfind_dir '/usr/share/backgrounds')"
    elif [ -d "${HOME}/Pictures/Wallpapers" ] ; then
        wallp="$(imfind_dir "${HOME}/Pictures/Wallpapers")"
    fi
fi

if [ -z "${wallp}" ] ; then
    echo "No image was found"
    exit 3
fi

# Save the background location, for quick setting in the future
cache_dir="${XDG_CACHE_HOME}/wpaper"
if [ -n "${XDG_CACHE_HOME}" ] && [ -d "${XDG_CACHE_HOME}" ] ; then 
    mkdir -p "${XDG_CACHE_HOME}/wpaper"
fi
ln -sf "${wallp}" "${cache_dir}/last_wallpaper"

# Operate on all the monitors
for monitor in $name ; do
  # Parse the proper WxH+x+y for this monitor
  res="$(echo "${info}" | jq --raw-output \
    '.[] | select(.name == "'"${monitor}"'") | .rect | (.width|tostring) + "x" + (.height|tostring) + "+" + (.x|tostring) + "+" + (.y|tostring)')"
  # Create the temporary splice
  thisfile="${cache_dir}/${monitor}.png"
  if [ -e "${thisfile}" ] ; then
    rm "${thisfile}"
  fi
  convert "${wallp}" -crop "${res}" +repage "${thisfile}"
  # Apply this wallpaper
  swaymsg output "${monitor}" bg "${thisfile}" fill
done
