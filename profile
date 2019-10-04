#!/bin/sh

# Import Path
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"

# Load profiles from /etc/profile.d
if test -d "${XDG_CONFIG_HOME}/profile.d/"; then
    for profile in "${XDG_CONFIG_HOME}/profile.d/"*.sh; do
        test -r "$profile" && . "$profile"
    done
    unset profile
fi
