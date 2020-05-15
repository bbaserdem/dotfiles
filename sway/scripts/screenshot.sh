#!/bin/dash
# This script gets a screenshot; with a couple possible options

# Allows the MODE flag which;
# * Enables all screen capture (default)
# * Enables current active window capture
# * Enables a rectangular selection to be captured
# * Enables to get the pixel color value underneath the cursor
#   (only available with TARGET=clipboard)
# Allows a CLIPBOARD flag which copies to clipboard
#   (as opposed to saving the file in the screenshots directory)


# Get the screenshots directory
screendir="${HOME}/Pictures/Screenshots"
timestamp="$(date +%Y-%m-%d_%H:%M:%S)"

mode='screen'
target='file'

while getopts "m:c" option ; do
  case "${option}" in
    m)  if [ "${OPTARG}" = 'screen' ] ; then mode="${OPTARG}"
      elif [ "${OPTARG}" = 'active' ] ; then mode="${OPTARG}"
      elif [ "${OPTARG}" = 'select' ] ; then mode="${OPTARG}"
      elif [ "${OPTARG}" = 'sample' ] ; then mode="${OPTARG}"
      else echo "Invalid mode argument \"${OPTARG}\""
      fi ;;
    c) target='clipboard' ;;
    *) echo "Invalid flag" ;;
  esac
done

case "${mode}" in
  screen)
    output="${screendir}/${timestamp}-screenshot.png"
    if [ "${target}" = 'file' ] ; then
      grim "${output}"
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot" "Saved to $(basename "${output}")"
    elif [ "${target}" = 'clipboard' ] ; then
      grim - | wl-copy
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot" "Copied to clipboard."
    fi
    ;;
  active)
    window="$(swaymsg -t get_tree | jq '.. | (.nodes? // empty)[] | select(.focused and .pid)')"
    name="$(echo "${window}" | jq -r '.app_id')"
    geom="$(echo "${window}" | jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"')"
    if [ "${name}" = '~' ] ; then name='TERM' ; fi
    output="${screendir}/${timestamp}-${name}.png"
    if [ "${target}" = 'file' ] ; then
      grim -g "${geom}" "${output}"
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Window)" "Saved to $(basename "${output}")"
    elif [ "${target}" = 'clipboard' ] ; then
      grim -g "${geom}" - | wl-copy
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Window)" "Copied to clipboard"
    fi
    ;;
  select)
    geom="$(slurp)"
    output="${screendir}/${timestamp}-loc:${geom}.png"
    if [ "${target}" = 'file' ] ; then
      grim -g "${geom}" "${output}"
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Selection)" "Saved to $(basename "${output}")"
    elif [ "${target}" = 'clipboard' ] ; then
      grim -g "${geom}" - | wl-copy
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Selection)" "Copied to clipboard"
    fi
    ;;
  sample)
    geom="$(slurp)"
    out="$(grim -g "${geom}" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-)"
    hex="$(echo "${out}" | sed --silent 's|^.*\(#[a-f,A-F,0-9]\+\).*$|\1|p')"
    echo "${hex}" | wl-copy
      notify-send --icon screengrab "Color sample" "${hex}, copied to clipboard"
    ;;
  *)
    echo "Not configured yet"
    exit 1
    ;;
esac
