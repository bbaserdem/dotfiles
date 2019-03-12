#!/bin/sh

_file="${HOME}/.cache/isync/password-Gmail.sh"
echo "#!/bin/sh
echo $(pass Google | grep 'app:' | awk '{print $2}')" > "${_file}"
chmod 700 "${_file}"
