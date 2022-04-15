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
#   Use ∶ (UTF-8 glyph) instead of colon (:) because android can't use it
#   Android string reservedChars = "?:\"*|/\\<>";


# Get the screenshots directory
case "$(hostname)" in
  sbp-laptop)       this_comp="/Laptop"       ;;
  sbp-workstation)  this_comp="/Laptop"       ;;
  sbp-homestation)  this_comp="/Homestation"  ;;
  sbp-server)       this_comp="/Workstation"  ;;
  *)                this_comp="/PC"           ;;
esac
screendir="${HOME}/Pictures/Screenshots/${this_comp}"
if [ ! -e "${screendir}" ] ; then mkdir -p "${screendir}" ; fi
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
      maim --quality 1 "${output}"
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot" "Saved to $(basename "${output}")"
    elif [ "${target}" = 'clipboard' ] ; then
      maim --quality 1 \
        | xclip -selection clipboard -t image/png
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot" "Copied to clipboard."
    fi
    ;;
  active)
    wid="$(xdotool getactivewindow)"
    name="$(xprop -id "${wid}" | awk '/WM_CLASS\(STRING\)/ {print $4}' | sed 's|"||g')"
    if [ "${wname}" = '~' ] ; then wname='TERM' ; fi
    output="${screendir}/${timestamp}-${name}.png"
    if [ "${target}" = 'file' ] ; then
      maim --quality 1 --window "${wid}" "${output}"
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Window)" "Saved to $(basename "${output}")"
    elif [ "${target}" = 'clipboard' ] ; then
      maim --quality 1 --window "${wid}" \
        | xclip -selection clipboard -t image/png
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Window)" "Copied to clipboard"
    fi
    ;;
  select)
    # Replace + with ✚, , x with ⨯
    geom="$(slop)"
    geom_txt="loc∶$(echo ${geom} | sed 's|+|✚|g;s|x|⨯|g')"
    # Use ∶, instead of :, for androd
    output="${screendir}/${timestamp}-${geom_txt}.png"
    if [ "${target}" = 'file' ] ; then
      maim --quality 1 --geometry "${geom}" "${output}"
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Selection)" "Saved to $(basename "${output}")"
    elif [ "${target}" = 'clipboard' ] ; then
      maim --quality 1 --geometry "${geom}" \
        | xclip -selection clipboard -t image/png
      canberra-gtk-play -i screen-capture &
      notify-send --icon screengrab "Screenshot (Selection)" "Copied to clipboard"
    fi
    ;;
  sample)
    out="$(maim -st 0 | convert - -resize 1x1\! -format '%[pixel:p{0,0}]' txt:-)"
    hex="$(echo "${_out}" | sed --silent 's|^.*\(#[a-f,A-F,0-9]\+\).*$|\1|p')"
    echo "${hex}" | xclip -selection clipboard
      notify-send --icon screengrab "Color sample" "${hex}, copied to clipboard"
    ;;
  *)
    echo "Not configured yet"
    exit 1
    ;;
esac
