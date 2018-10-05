#!/usr/bin/sh
_src="${XDG_CONFIG_HOME}/vdirsyncer/getPass.sh"
echo '#!/usr/bin/sh
case "$1+$2" in' > "${_src}"
for _app in CardDAV CalDAV
do
    echo "    ${_app}+pass) echo '$(pass "${_app}"|head -n 1|sed 's|'"'"'|'"'"'"'"'"'"'"'"'|g')';;
    ${_app}+user) echo '$(pass "${_app}"|grep 'username:'|awk '{print $2}')' ;;" >> "${_src}"
done
echo 'esac' >> "${_src}"
chmod 700 "${_src}"
