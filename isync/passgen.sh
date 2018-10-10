#!/usr/bin/sh

_file="${XDG_CONFIG_HOME}/isync/password-Gmail.sh"
echo "#!/usr/bin/sh
echo $(pass Google | grep 'app:' | awk '{print $2}')" > "${_file}"
chmod 700 "${_file}"
