#!/bin/sh

_file="${HOME}/.cache/isync/password-Gmail.sh"
if [ -z "${_file}" ] ; then rm "${_file}" ; fi
echo "#!/bin/sh" > "${_file}"
echo "$(pass Google | grep 'app:' | awk '{print $2}')" > "${_file}"
chmod 700 "${_file}"
