#!/usr/bin/sh

_file="${XDG_CONFIG_HOME}/mpdscribble.conf"

echo "[mpdscribble]
verbose = 2
host = localhost
port = 6600
log = /home/sbp/.cache/mpdscribble.log
verbose = 2
proxy = none

[last.fm]
url = http://post.audioscrobbler.com/
journal = /var/cache/mpdscribble/lastfm.journal" > "${_file}"
echo "username = $(pass LastFM|grep 'username:'|awk '{print $2}')" >> "${_file}"
echo "password = $(pass LastFM|head -n 1|md5sum|awk '{print $1}')" >> "${_file}"
chmod 700 "${_file}"
