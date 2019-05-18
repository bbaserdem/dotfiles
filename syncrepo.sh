#!/bin/sh

_repo=${1:$XDG_CONFIG_HOME}

# Sync the config repo
/usr/bin/git -C "${_repo}" pull

# Check if there are conflicts
if [ "$(git -C ${_repo} ls-files -u | wc -l)" -gt 0 ] ; then
    _txt="Repo at ${_repo} has conflicting files, aborting"
    /usr/bin/notify-send 'Git Conflict' "${_txt}"
    exit 1
fi

# Push changes
if [ -z "$(/usr/bin/git status -C ${_repo} status --porcelain)" ] ; then
    _message="Autosync by $(/bin/hostname) at $(date +%Y-%m-%d_%H:%M:%S)"
    /usr/bin/git -C "$_repo" add -A
    /usr/bin/git -C "$_repo" commit -m "${_message}"
    /usr/bin/git -C "$_repo" push
fi
