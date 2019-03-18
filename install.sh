#!/bin/sh
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'

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
    ln -sf "${HOME}/.config/gpg-agent.conf"     "${HOME}/.gnupg/gpg-agent.conf"
    ln -sf "${HOME}/.config/abcde.conf"         "${HOME}/.abcde.conf"
    ln -sf "${HOME}/.config/cursor/index.theme" "${HOME}/.icons/default/"
    ln -sf "${HOME}/.config/latex/latexmkrc"    "${HOME}/.latexmkrc"
    ln -sf "${HOME}/.config/tmux.conf"          "${HOME}/.tmux.conf"
<<<<<<< HEAD

    # Setting profile picture
    ln -sf "${HOME}/Pictures/Profile/Linux_login_profile" "${HOME}/.face"
    ln -sf "${HOME}/Pictures/Profile/Linux_login_profile" "${HOME}/.face.icon"
=======
    ln -sf "${HOME}/.face"                      "${HOME}/.face.icon"
>>>>>>> ae4222f6fff2eb1d72093fbe5d85c7f1751d60e4
}

local_update () {
    # Neovim
    echo "Installing local packages through pip for neovim . . .\n"
    pip install --user neovim
    pip install --user neovim-remote
    pip install --user pexpect

    # ZIM
    echo "Installing/updating zim . . .\n"
    if [ ! -d "${ZIM_HOME}" ] ; then
        git clone --recursive 'https://github.com/zimfw/zimfw' "${ZIM_HOME}"
    else
        git -C "${ZIM_HOME}" pull
        zmanage update
    fi

    # Powerlevel10k and powerlevel9k
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
    if [ -x '/usr/bin/dropbox' ] ; then
        [ -d "${HOME}/.dropbox-dist" ] && rm -rf "${HOME}/.dropbox-dist"
        install --mode 0 --directory "${HOME}/.dropbox-dist"
    fi

    # Steam stuff
    mkdir -p ~/.local/share/Steam/skins
    if [ -d "${HOME}/.local/share/Steam/Air" ] ; then
        git -C "${HOME}/.local/share/Steam/Air" pull
    else
        git clone 'https://github.com/airforsteam/Air-for-Steam.git' "${HOME}/.local/share/Steam/Air"
    fi

    # Qutebrowser
    if [ -x '/usr/share/qutebrowser/scripts/dictcli.py' ] ; then
        /usr/share/qutebrowser/scripts/dictcli.py install en-US tr-TR
    fi

    # Breeze hacked cursor theme
    if [ ! -d /tmp/breeze-hacked ] ; then
        git clone 'https://github.com/codejamninja/breeze-hacked-cursor-theme' /tmp/breeze-hacked
    fi
    make --directory /tmp/breeze-hacked install

    # Rofi-pass and emoji
    wget --output-document "${XDG_CONFIG_HOME}/rofi/rofi-pass" \
        'https://raw.githubusercontent.com/carnager/rofi-pass/master/rofi-pass'
    chmod 775 "${XDG_CONFIG_HOME}/rofi/rofi-pass"
    wget  --output-document "${XDG_CONFIG_HOME}/rofi/rofi-emoji.py" \
        'https://raw.githubusercontent.com/fdw/rofimoji/master/rofimoji.py'
    chmod 775 "${XDG_CONFIG_HOME}/rofi/rofi-emoji.py"

    # Generator scripts for passwords
    ${XDG_CONFIG_HOME}/isync/passgen.sh
    ${XDG_CONFIG_HOME}/mpdscribble-confgen.sh
    ${XDG_CONFIG_HOME}/vdirsyncer/passgen.sh
    ${XDG_CONFIG_HOME}/s3cfg-gen.sh

    # Papirus icons
    wget --output-document "${HOME}/.cache/papirus_install.sh" \
        'https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh'
    chmod 775 ${HOME}/.cache/papirus_install.sh
    DESTDIR="$HOME/.local/share/icons" ${HOME}/.cache/papirus_install.sh

    # Nerdfonts
    if [ ! -d /tmp/nerd-fonts ] ; then
        git clone 'https://github.com/ryanoasis/nerd-fonts.git' /tmp/nerd-fonts
    fi
    if [ -x '/tmp/nerd-fonts/install.sh' ] ; then
        /tmp/nerd-fonts/install.sh --install-to-user-path --complete --copy Iosevka
    fi
}

# Help text
print_usage() {
    echo "Usage:"
    echo "    -p            Fix permissions"
    echo "    -l            Do symlinks and directories"
    echo "    -u            Update/install local packages and configs"
    echo "    -s            Full setup (do all options)"
    echo "    -h            Display this help message"
}

unset flag

while getopts ':Aplush' flag; do
    case "${flag}" in
        p) fix_perm ;;
        l) symlinks_and_directories ;;
        u) local_update ;;
        s) fix_perm; symlinks_and_directories; local_update ;;
        h) print_usage ;;
        \?) print_usage ; exit 1 ;;
    esac
done

if [ -z "$flag" ]
then
    fix_perm
    symlinks_and_directories
    local_update
fi
