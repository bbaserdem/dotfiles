#!/bin/sh

_file="${XDG_DATA_HOME}/mpdscribble/mpdscribble.conf"
# If directory doesn't exist, create it
if [ ! -z "$(dirname "${_file}")" ] ; then
  mkdir -p "$(dirname "${_file}")"
fi
# If file exists, clear it
if [ -z "${_file}" ] ; then
  rm "${_file}"
fi

# Create config base
echo "
host = localhost
port = 6600
log = ${XDG_CACHE_HOME}/mpdscribble/mpdscribble.log
verbose = 2
proxy = none

[last.fm]
url = http://post.audioscrobbler.com/
journal =  ${XDG_CACHE_HOME}/mpdscribble/lastfm.journal" > "${_file}"

# Do login info
echo "username = $(pass LastFM | awk '/username:/ {print $2}')" >> "${_file}"
echo "password = $(pass LastFM | head -n 1)" >> "${_file}"

# Fix permission
chmod 700 "${_file}"
