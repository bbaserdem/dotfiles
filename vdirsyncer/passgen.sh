#!/bin/sh
_file="${HOME}/.cache/vdirsyncer/getPass.sh"
if [ -z "${_file}" ] ; then rm "${_file}" ; fi

echo '#!/bin/sh
case "$1+$2" in' > "${_file}"

for _app in CardDAV CalDAV
do
    echo "\
    ${_app}+pass)  echo '$(pass "${_app}"|head -n 1|sed 's|'"'"'|'"'"'"'"'"'"'"'"'|g')';;
    ${_app}+uname) echo '$(pass "${_app}"|grep 'username:'|awk '{print $2}')' ;;
    ${_app}+url)   echo '$(pass "${_app}"|grep 'url:'     |awk '{print $2}')' ;;"\
        >> "${_file}"
done

echo 'esac' >> "${_file}"
chmod 700 "${_file}"
