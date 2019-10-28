#!/bin/bash
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\t'

fix_perm () {
    # Manage permission of home folder
    chmod 755 "${HOME}"
    chmod -R u=rwX,g=,o= "${HOME}/.ssh"
    chmod -R u=rwX,g=,o= "${HOME}/.gnupg"
    chmod 600 "${XDG_CONFIG_HOME}/gpg-agent.conf"
    chmod 644 "${HOME}/.face"
    chmod 644 "${HOME}/.face.icon"
}

symlinks_and_directories () {
    # Place symlinks
    echo 'Creating directories and symlinks. . .'
    mkdir -p "${HOME}/Documents/MATLAB"
    mkdir -p "${HOME}/.local/"{share/fonts,wineprefixes,bin}
    mkdir -p "${HOME}/.cache/"{mpd,isync,mpdscribble,vdirsyncer,newsboat}
    mkdir -p "${HOME}/.icons/default"

    # Remove local applications folder, and link the one from config
    rm -rf "${HOME}/.local/share/applications"
    ln -sf "${XDG_CONFIG_HOME}/applications" "${HOME}/.local/share/applications"

    # Remmina config; to be shared from Documents
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
    ln -sf "${HOME}/.config/gtk-2.0/gtkrc"      "${HOME}/.gtkrc-2.0"
    ln -sf "${HOME}/.config/gpg-agent.conf"     "${HOME}/.gnupg/gpg-agent.conf"
    ln -sf "${HOME}/.config/abcde.conf"         "${HOME}/.abcde.conf"
    ln -sf "${HOME}/.config/cursor/index.theme" "${HOME}/.icons/default/"
    ln -sf "${HOME}/.config/latex/latexmkrc"    "${HOME}/.latexmkrc"
    ln -sf "${HOME}/.config/tmux.conf"          "${HOME}/.tmux.conf"

    # Setting profile picture
    ln -sf "${HOME}/Pictures/Profile/Linux_login_profile" "${HOME}/.face"
    ln -sf "${HOME}/Pictures/Profile/Linux_login_profile" "${HOME}/.face.icon"

    # Matlab config
    ln -sf "${XDG_CONFIG_HOME}/matlab" "${HOME}/.matlab"
}

local_update () {
    # Neovim
    echo "Installing local python packages from pip . . ."
    pip install --user inotify pulsectl 'https://github.com/dlenski/vpn-slice/archive/master.zip'

    # Dropbox stuff
    echo "Fixing dropbox update . . ."
    if [ -x '/usr/bin/dropbox' ] ; then
        [ -d "${HOME}/.dropbox-dist" ] && rm -rf "${HOME}/.dropbox-dist"
    fi
    install --mode 0 --directory "${HOME}/.dropbox-dist"

    # Steam stuff
    echo "Installing steam theme . . ."
    if [ -d /usr/share/steam/skins/air-for-steam ] ; then
        echo 'Air for steam installed, skipping . . .'
    else
        mkdir -p "${HOME}/.local/share/Steam/skins"
        if [ -d "${HOME}/.local/share/Steam/skins/Air" ] ; then
            git -C "${HOME}/.local/share/Steam/skins/Air" pull
        else
            git clone 'https://github.com/airforsteam/Air-for-Steam.git' "${HOME}/.local/share/Steam/skins/Air"
        fi
    fi

    # Rofi-pass
    echo "Installing rofi-pass . . ."
    if [ -x '/usr/bin/rofi-pass' ] ; then
        echo 'rofi-pass is installed, skipping . . .'
    else
        wget --output-document "${XDG_CONFIG_HOME}/rofi/rofi-pass" \
            'https://raw.githubusercontent.com/carnager/rofi-pass/master/rofi-pass'
        chmod 775 "${XDG_CONFIG_HOME}/rofi/rofi-pass"
    fi

    # Syncthing ignore
    echo "Generating syncthing ignore files"
    _stfold=("${HOME}/Pictures" "${HOME}/Documents" "${HOME}/Downloads" "${HOME}/Music" "${HOME}/Videos")
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

}

icons_config () {
    # Breeze hacked cursor theme
    echo "Installing cursor themes . . ."
    if [ -d /usr/share/icons/Breeze_Hacked ] ; then
        echo "Breeze-hacked exists, skipping . . ."
    else
        echo "Locally installing Breeze-Hacked . . ."
        if [ -d "${HOME}/.cache/breeze-hacked" ] ; then
            git -c "${HOME}/.cache/Breeze-Hacked" pull
        else
            git clone 'https://github.com/codejamninja/breeze-hacked-cursor-theme' "${HOME}/.cache/Breeze-Hacked"
        fi
        make --directory "${HOME}/.cache/Breeze-Hacked" install
    fi

    # Icons
    echo "Getting icons . . ."
    if [ -d /usr/share/icons/Papirus-Dark ] ; then
        echo "Papirus exists, skipping . . ."
    else
        echo "Locally installing Papirus . . ."
        wget --output-document "${HOME}/.cache/papirus_install.sh" \
            'https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh'
        chmod 775 ${HOME}/.cache/papirus_install.sh
        DESTDIR="$HOME/.local/share/icons" ${HOME}/.cache/papirus_install.sh
    fi

    # Nerdfonts
    echo "Installing fonts"

    # Iosevka
    if [ -d /usr/share/fonts/ttf-iosevka ] ; then
        echo 'Iosevka installed, skipping nerdfont version . . .'
    else
        echo "Installing Iosevka Nerd Font Complete . . ."
        if [ ! -d "${HOME}/.cache/nerdfonts" ] ; then
            git clone 'https://github.com/ryanoasis/nerd-fonts.git' "${HOME}/.cache/nerdfonts"
        else
            git clone -C "${HOME}/.cache/nerdfonts" pull
        fi
        "${HOME}/.cache/nerdfonts/install.sh" --install-to-user-path --complete --copy Iosevka
    fi

    # Sauce code pro
    if [ -d '/usr/share/fonts/TTF/Sauce Code Pro Nerd Font Complete Moto.ttf' ] ; then
        echo 'Sauce Code Pro Nerd Font Complete installed, skipping'
    else
        echo "Installing Sauce Code Pro Nerd Font Complete . . ."
        if [ ! -d "${HOME}/.cache/nerdfonts" ] ; then
            git clone 'https://github.com/ryanoasis/nerd-fonts.git' "${HOME}/.cache/nerdfonts"
        else
            git clone -C "${HOME}/.cache/nerdfonts" pull
        fi
        "${HOME}/.cache/nerdfonts/install.sh" --install-to-user-path --complete --copy SourceCodePro
    fi

    # Fira code
    if [ -d '/usr/share/fonts/OTF/Fura Code Regular Nerd Font Complete Mono.otf' ] ; then
        echo 'Fura Code Nerd Font Complete Mono installed, skipping'
    else
        echo "Installing Fura Code Nerd Font Complete Mono . . ."
        if [ ! -d "${HOME}/.cache/nerdfonts" ] ; then
            git clone 'https://github.com/ryanoasis/nerd-fonts.git' "${HOME}/.cache/nerdfonts"
        else
            git clone -C "${HOME}/.cache/nerdfonts" pull
        fi
        "${HOME}/.cache/nerdfonts/install.sh" --install-to-user-path --complete --copy FiraCode
    fi
}

archive_keys () {
    # Function to do a backup of various keys in the home folder
    _tgt="Keys_$(hostname).tar"
    if [ -f "${HOME}/${_tgt}" ] ; then
        mv "${HOME}/${_tgt}" "${HOME}/${_tgt}_old_$(date '+%Y%m%d-%H:%M')"
    fi

    # Change to home directory
    cd ${HOME} 1>/dev/null

    # Create archive
    tar -c -f "${_tgt}" --files-from /dev/null

    # Add SSH keys
    tar -f "${_tgt}" -r ".ssh"

    # Add gpg keys
    if [ -z "${GNUPGHOME}" ] ; then
        tar -f "${_tgt}" -r ".gnupg"
    else
        tar -f "${_tgt}" -r "${GNUPGHOME#"${HOME}/"}"
    fi

    # Add syncthing config files
    if [ -z "${XDG_CONFIG_HOME}" ] ; then
        _syn=".config/syncthing"
    else
        _syn="${XDG_CONFIG_HOME#"${HOME}/"}/syncthing"
    fi
    _cer=('cert.pam' 'config.xml' 'csrftokens.txt' 'https-cert.pem' 'https-cert.pem' 'key.pem')
    for _file in "${_cer[@]}" ; do
        if [ -f "${_syn}/${_file}" ] ; then
            tar -f "${_tgt}" -r "${_syn}/${_file}"
        fi
    done

    cd - 1>/dev/null
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
    icons_config
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
    echo "    -i            (I)nstall icons and fonts"
    echo "    -e            (E)xtract keys from backup"
}

if [ -z "${1}" ] ; then
    echo "No flags set, defaulting to full config"
    run_all
else
    while getopts ':aplushie' flag; do
        case "${flag}" in
            a) archive_keys ;;
            p) fix_perm ;;
            l) symlinks_and_directories ;;
            u) local_update ;;
            s) run_all ;;
            h) print_usage ;;
            i) icons_config ;;
            e) extract_keys ;;
            *) echo "Unknown option ${flag}"; print_usage ; exit 1 ;;
        esac
    done
fi
