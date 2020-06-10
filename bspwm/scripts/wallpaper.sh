#!/bin/dash
# This script refreshes backdrop of desktops when called

# Get rectangle information of the screen
_rect="$(xdpyinfo | awk '/dimensions/ {print $2;}')"
_x="$(echo "${_rect}" | sed 's|\([0-9]*\)x\([0-9]*\)|\1|')"
_y="$(echo "${_rect}" | sed 's|\([0-9]*\)x\([0-9]*\)|\2|')"

# Set a theme
_theme=''
if [ -n "${1}" ] && [ ! -d "${1}" ] ; then
  _theme="${1}"
elif [ -n "${2}" ] ; then
  _theme="${2}"
fi

imfind_dir () {
  find "$1" -type f -a '(' \
    -iname "${_theme}*.jpg"  -o \
    -iname "${_theme}*.jpeg" -o \
    -iname "${_theme}*.png" ')' -print 2>/dev/null \
    | shuf -n 1 -
}

_img=''
# Try to find image; if a dir is specified
if [ -n "${SBP_XPAPER_DIR}" ] && [ -d "${SBP_XPAPER_DIR}" ]; then
  if [ -d "${SBP_XPAPER_DIR}/${_x}x${_y}" ] ; then
    _img="$(imfind_dir "${SBP_XPAPER_DIR}/${_x}x${_y}")"
  else
    _img="$(imfind_dir "${SBP_XPAPER_DIR}")"
  fi
# If the dir is not specified; try to find one in other locations
else
  # Check if a directory was given as a positional argument
  if [ -n "${1}" ] && [ -d "${1}" ] ; then
    _img="$(imfind_dir "${1}")"
  elif [ -d '/usr/share/backgrounds' ] ; then
    _img="$(imfind_dir '/usr/share/backgrounds')"
  elif [ -d "${HOME}/Pictures/Wallpapers" ] ; then
    _img="$(imfind_dir "${HOME}/Pictures/Wallpapers")"
  fi
fi

if [ -z "${_img}" ] ; then
  echo "No image was found"
  exit 3
fi

# Save the background location, for quick setting in the future
if [ -n "${XDG_CACHE_HOME}" ] && [ -d "${XDG_CACHE_HOME}" ] ; then 
  mkdir -p "${XDG_CACHE_HOME}/xpaper"
fi
ln -sf "${_img}" "${XDG_CACHE_HOME}/xpaper/last_wallpaper"

# Set without using Xinerama
feh --no-fehbg --bg-scale --no-xinerama "${_img}"
