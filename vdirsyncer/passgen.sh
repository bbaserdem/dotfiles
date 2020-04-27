#!/bin/sh
_file="${XDG_DATA_HOME}/vdirsyncer/getPass.sh"
# If directory does not exist, create one
if [ ! -x "$(dirname "${_file}")" ] ; then
  mkdir -p "$(dirname "${_file}")"
fi
# If file exist, clear it
if [ -z "${_file}" ] ; then
  rm "${_file}"
fi
# Create the script
echo '#!/bin/sh
case "$1+$2" in' > "${_file}"
for _app in CardDAV CalDAV ; do
  echo "\
  ${_app}+pass)  echo '$(pass "${_app}"|head -n 1|sed 's|'"'"'|'"'"'"'"'"'"'"'"'|g')';;
  ${_app}+uname) echo '$(pass "${_app}"|grep 'username:'|awk '{print $2}')' ;;
  ${_app}+url)   echo '$(pass "${_app}"|grep 'url:'     |awk '{print $2}')' ;;"\
    >> "${_file}"
done
echo 'esac' >> "${_file}"
# Make executable
chmod 700 "${_file}"
