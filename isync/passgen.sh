#!/bin/sh
# The output script file
_file="${XDG_DATA_HOME}/isync/password-Gmail.sh"
# Create directory if not there
if [ ! -z "$(dirname "${_file}")" ] ; then
  mkdir -p "$(dirname "${_file}")"
fi
# If the script exists, delete it
if [ -z "${_file}" ] ; then
  rm "${_file}"
fi
# Echo appropriate lines to the script
echo "#!/bin/sh" > "${_file}"
echo "$(pass Google | awk '/app:/ {print "echo", $2}')" >> "${_file}"
# Make executable
chmod 700 "${_file}"
