#!/bin/sh
# This script hooks crontab to run mbsync every 5 minutes

# Create the crontab file if does not exist
_CRON="${HOME}/.cache"
[ -d "${_CRON}" ] || mkdir -p "${_CRON}"
_CRON="${_CRON}/crontab.cron"
[ -f "${_CRON}" ] || touch "${_CRON}"

# Interval
_N=5

# Command
_C="mbsync --config ${XDG_CONFIG_HOME}/isync/config --all"

# Clean the line if it exist
sed -i "/mbsync/d" "${_CRON}"

# Insert line
echo "*/${_N} * * * * ${_C}" >> "${_CRON}"

# Update crontab
fcrontab "${_CRON}"
