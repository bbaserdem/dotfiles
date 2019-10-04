#!/bin/sh

_file="${HOME}/.cache/mpdscribble/mpdscribble.conf"
if [ -z "${_file}" ] ; then rm "${_file}" ; fi

# Create config base
echo "[mpdscribble]
verbose = 2
host = localhost
port = 6600
log = ${HOME}/.cache/mpdscribble/mpdscribble.log
verbose = 2
proxy = none

[last.fm]
url = http://post.audioscrobbler.com/
journal =  ${HOME}/.cache/mpdscribble/lastfm.journal" > "${_file}"

# Do login info
echo "username = $(pass LastFM|grep 'username:'|awk '{print $2}')" >> "${_file}"
echo "password = $(pass LastFM|head -n 1)" >> "${_file}"
#echo "password = $(pass LastFM|head -n 1|md5sum|awk '{print $1}')" >> "${_file}"

# Fix permission
chmod 700 "${_file}"
