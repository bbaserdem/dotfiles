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
    mkdir -p "${HOME}/.cache/"{mpd,isync,mpdscribble,vdirsyncer}
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
}

local_update () {
    # Neovim
    echo "Installing local python packages from pip . . ."
    pip install --user inotify pulsectl 'https://github.com/dlenski/vpn-slice/archive/master.zip'

    # ZIM
    echo "Installing/updating zim . . ."
    if [ ! -d "${ZIM_HOME}" ] ; then
        git clone --recursive 'https://github.com/zimfw/zimfw' "${ZIM_HOME}"
    else
        git -C "${ZIM_HOME}" pull
        zsh -ci 'zmanage update'
    fi

    # Powerlevel10k and powerlevel9k
    echo "Installing zsh prompts . . ."
    if [ ! -d "${ZIM_HOME}/modules/prompt/external-themes/powerlevel10k" ]
    then
        git clone --recursive 'https://github.com/romkatv/powerlevel10k.git' \
            "${ZIM_HOME}/modules/prompt/external-themes/powerlevel10k"
    else
        git -C "${ZIM_HOME}/modules/prompt/external-themes/powerlevel10k" pull
    fi
    if [ ! -d "${ZIM_HOME}/modules/prompt/external-themes/powerlevel9k" ]
    then
        git clone --recursive 'https://github.com/romkatv/powerlevel9k.git' \
            "${ZIM_HOME}/modules/prompt/external-themes/powerlevel9k"
    else
        git -C "${ZIM_HOME}/modules/prompt/external-themes/powerlevel9k" pull
    fi
    ln -sf "${ZIM_HOME}/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme" \
        "${ZIM_HOME}/modules/prompt/functions/prompt_powerlevel9k_setup"
    ln -sf "${ZIM_HOME}/modules/prompt/external-themes/powerlevel10k/powerlevel10k.zsh-theme" \
        "${ZIM_HOME}/modules/prompt/functions/prompt_powerlevel10k_setup"

    # Dropbox stuff
    echo "Fixing dropbox update . . ."
    if [ -x '/usr/bin/dropbox' ] ; then
        [ -d "${HOME}/.dropbox-dist" ] && rm -rf "${HOME}/.dropbox-dist"
    fi
    install --mode 0 --directory "${HOME}/.dropbox-dist"

    # Steam stuff
    echo "Installing steam theme . . ."
    mkdir -p "${HOME}/.local/share/Steam/skins"
    if [ -d "${HOME}/.local/share/Steam/skins/Air" ] ; then
        git -C "${HOME}/.local/share/Steam/skins/Air" pull
    else
        git clone 'https://github.com/airforsteam/Air-for-Steam.git' "${HOME}/.local/share/Steam/skins/Air"
    fi

    # Qutebrowser
    echo "Setting up qutebrowser spellcheck . . ."
    if [ -x '/usr/share/qutebrowser/scripts/dictcli.py' ] ; then
        /usr/share/qutebrowser/scripts/dictcli.py install en-US tr-TR
    fi

    # Rofi-pass
    echo "Installing rofi-pass . . ."
    wget --output-document "${XDG_CONFIG_HOME}/rofi/rofi-pass" \
        'https://raw.githubusercontent.com/carnager/rofi-pass/master/rofi-pass'
    chmod 775 "${XDG_CONFIG_HOME}/rofi/rofi-pass"

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
        if [ -e "${_fl}/Stignore/$(hostname)" ] ; then
            echo "// Block files according to $(hostname)"  >> "${_fl}/.stignore"
            echo "#include Stignore/$(hostname)"            >> "${_fl}/.stignore"
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
    echo "Installing cursor themes"
    echo "Breeze-hacked"
    if [ ! -d "${HOME}/.cache/breeze-hacked" ] ; then
        git clone 'https://github.com/codejamninja/breeze-hacked-cursor-theme' /tmp/breeze-hacked
    else
        git -c "${HOME}/.cache/breeze-hacked" pull
    fi
    make --directory "${HOME}/.cache/breeze-hacked" install

    # Icons
    echo "Getting icons"
    echo "Papirus"
    wget --output-document "${HOME}/.cache/papirus_install.sh" \
        'https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh'
    chmod 775 ${HOME}/.cache/papirus_install.sh
    DESTDIR="$HOME/.local/share/icons" ${HOME}/.cache/papirus_install.sh

    # Nerdfonts
    echo "Installing fonts"
    echo "Nerdfonts"
    if [ ! -d "${HOME}/.cache/nerdfonts" ] ; then
        git clone 'https://github.com/ryanoasis/nerd-fonts.git' "${HOME}/.cache/nerdfonts"
    else
        git clone -C "${HOME}/.cache/nerdfonts" pull
    fi
    if [ -x "${HOME}/.cache/nerdfonts/install.sh" ] ; then
        echo "Iosevka Nerd Font Complete"
        "${HOME}/.cache/nerdfonts/install.sh" --install-to-user-path --complete --copy Iosevka
        echo "Fura Code Nerd Font Complete"
        "${HOME}/.cache/nerdfonts/install.sh" --install-to-user-path --complete --copy FiraCode
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
    echo "    -p            Fix permissions"
    echo "    -l            Do symlinks and directories"
    echo "    -u            Update/install local packages and configs"
    echo "    -s (default)  Full setup (do all options)"
    echo "    -h            Display this help message"
    echo "    -i            Install icons and fonts"
}

if [ -z "${1}" ] ; then
    echo "No flags set, defaulting to full config"
    run_all
else
    while getopts ':plushi' flag; do
        case "${flag}" in
            p) fix_perm ;;
            l) symlinks_and_directories ;;
            u) local_update ;;
            s) run_all ;;
            h) print_usage ;;
            i) icons_config ;;
            *) echo "Unknown option ${flag}"; print_usage ; exit 1 ;;
        esac
    done
fi
