#!/bin/bash
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\t'

fix_perm () {
    # Manage permission of home folder
    chmod 755 "${HOME}"
    chmod -R u=rwX,g=,o= "${XDG_DATA_HOME}/ssh"
    chmod -R u=rwX,g=,o= "${XDG_DATA_HOME}/gnupg"
    chmod 600 "${XDG_CONFIG_HOME}/gpg-agent.conf"
    chmod 644 "${HOME}/.face"
    chmod 644 "${HOME}/.face.icon"
}

symlinks_and_directories () {
    # Place symlinks
    echo 'Creating directories and symlinks. . .'
    mkdir -p "${HOME}/.local/"{share/fonts,wineprefixes,bin,newsboat,vdirsyncer,mpdscribble}
    mkdir -p "${HOME}/.cache/"{mpd,isync,mpdscribble,vdirsyncer,newsboat}
    mkdir -p "${HOME}/.icons/default"

    # Remmina configs; to be shared from Documents
    ln -sf "${HOME}/Documents/Remmina" "${HOME}/.local/share/remmina"

    # Fallback values for bash shell
    ln -sf "${HOME}/.config/bash/bashrc" "${HOME}/.bashrc"
    ln -sf "${HOME}/.config/bash/login"  "${HOME}/.bash_profile"
    ln -sf "${HOME}/.config/bash/logout" "${HOME}/.bash_logout"

    # Things for Xorg/Login manager
    ln -sf "${HOME}/.config/X11/clientrc"  "${HOME}/.xinitrc"
    ln -sf "${HOME}/.config/X11/serverrc"  "${HOME}/.xserverrc"
    ln -sf "${HOME}/.config/X11/resources" "${HOME}/.Xresources"
    ln -sf "${HOME}/.config/X11/profile"   "${HOME}/.xprofile"
    ln -sf "${HOME}/.config/X11/session"   "${HOME}/.xsession"
    ln -sf "${HOME}/.config/X11/keymap"    "${HOME}/.Xkbmap"

    # Non-xdg-compliant configuration options
    ln -sf "${HOME}/.config/abcde.conf"         "${HOME}/.abcde.conf"
    ln -sf "${HOME}/.config/gtk-2.0/gtkrc"      "${HOME}/.gtkrc-2.0"
    ln -sf "${HOME}/.config/cursor/index.theme" "${HOME}/.icons/default/"
    ln -sf "${HOME}/.config/latex/latexmkrc"    "${HOME}/.latexmkrc"
    ln -sf "${HOME}/.config/matlab"             "${HOME}/.matlab"
    ln -sf "${HOME}/.config/tmux.conf"          "${HOME}/.tmux.conf"

    # Setting profile picture
    ln -sf "${HOME}/Pictures/Profile/Linux_login_profile" "${HOME}/.face"
    ln -sf "${HOME}/Pictures/Profile/Linux_login_profile" "${HOME}/.face.icon"
}

local_update () {

  # Syncthing ignore
  echo "Generating syncthing ignore files"
  _stfold=("${HOME}/Pictures" "${HOME}/Documents" "${HOME}/Work" "${HOME}/Music" "${HOME}/Videos")
  for _fl in "${_stfold[@]}" ; do
    # Create/clear stignore file
    echo "// Syncthing ignore file"                 > "${_fl}/.stignore"
    if [ -e "${_fl}/Stignore/general" ] ; then
      echo "// Ignore generic stuff"                  >> "${_fl}/.stignore"
      echo "#include Stignore/general"                >> "${_fl}/.stignore"
    fi
    # Strip hostname
    _name="$(hostname | sed -n 's|sbp-\(.*\)|\1|p')"
    if [ ! -z "${_name}" ]; then
      if [ -e "${_fl}/Stignore/${_name}" ] ; then
        echo "// Block files according to ${_name}" >> "${_fl}/.stignore"
        echo "#include Stignore/${_name}"           >> "${_fl}/.stignore"
      fi
    fi
  done

  # Generator scripts for passwords
  echo "Genorating local password files . . ."
  ${XDG_CONFIG_HOME}/isync/passgen.sh
  ${XDG_CONFIG_HOME}/mpdscribble-confgen.sh
  ${XDG_CONFIG_HOME}/vdirsyncer/passgen.sh
  ${XDG_CONFIG_HOME}/s3cfg-gen.sh

  # Initialize vdirsyncer
  echo "Initializing vdirsyncer . . ."
  vdirsyncer discover calendar
  vdirsyncer discover contacts
}

archive_keys () {
  # Function to do a backup of various keys in the home folder
  _tgt="Keys_$(hostname).tar"
  if [ -f "${HOME}/${_tgt}" ] ; then
    mv "${HOME}/${_tgt}" "${HOME}/${_tgt}_old_$(date '+%Y%m%d-%H:%M')"
  fi

  # Change to home directory
  cd "${HOME}" || exit

  # Create archive
  tar -c -f "${_tgt}" --files-from /dev/null

  # Add SSH keys
  tar -f "${_tgt}" -r "${XDG_DATA_HOME}/ssh"

  # Add gpg keys
  if [ -z "${GNUPGHOME}" ] ; then
    tar -f "${_tgt}" -r "${XDG_DATA_HOME}/gnupg"
  else
    tar -f "${_tgt}" -r "${GNUPGHOME}"
  fi

  # Add syncthing config files
  if [ -z "${XDG_CONFIG_HOME}" ] ; then
    _syn=".config/syncthing"
  else
    _syn="${XDG_CONFIG_HOME}/syncthing"
  fi
  _cer=('cert.pam' 'config.xml' 'csrftokens.txt' 'https-cert.pem' 'https-cert.pem' 'key.pem')
  for _file in "${_cer[@]}" ; do
    if [ -f "${_syn}/${_file}" ] ; then
      tar -f "${_tgt}" -r "${_syn}/${_file}"
    fi
  done

  cd - || exit
}

extract_keys () {
  _tgt="${HOME}/Keys_$(hostname).tar"
  if [ ! -f "${_tgt}" ] ; then
    echo "Archive not found, ${_tgt}"
  else
    tar -f "${_tgt}" -x -C "${HOME}"
  fi
    
}

run_all () {
    fix_perm
    symlinks_and_directories
    local_update
}

# Help text
print_usage() {
    echo "Usage:"
    echo "    -a            Backup an (a)rchive of private keys"
    echo "    -p            Fix (p)ermissions"
    echo "    -l            Do sym(l)inks and directories"
    echo "    -u            (U)pdate local packages and configs"
    echo "    -s (default)  Full (s)etup (do all options)"
    echo "    -h            Display this (h)elp message"
    echo "    -e            (E)xtract keys from backup"
}

if [ -z "${1}" ] ; then
  echo "No flags set, defaulting to full config"
  run_all
else
  while getopts ':aplushe' flag; do
    case "${flag}" in
      a) archive_keys ;;
      p) fix_perm ;;
      l) symlinks_and_directories ;;
      u) local_update ;;
      s) run_all ;;
      h) print_usage ;;
      e) extract_keys ;;
      *) echo "Unknown option ${flag}"; print_usage ; exit 1 ;;
    esac
  done
fi
