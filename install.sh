#!/usr/bin/sh
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'

# Manage permission of home folder
chmod 755 "${HOME}"

# Place symlinks
echo '[config-install]==> Symlinking...\n'
mkdir -p ~/Documents/MATLAB
mkdir -p ~/.local/{share,wineprefixes}
mkdir -p ~/.cache/mpd
mkdir -p ~/.icons/default
ln -sf ~/Documents/Remmina ~/.local/share/remmina
ln -sf ~/.config/abcde.conf ~/.abcde.conf
ln -sf ~/.config/bash/bashrc ~/.bashrc
ln -sf ~/.config/bash/login ~/.bash_profile
ln -sf ~/.config/bash/logout ~/.bash_logout
ln -sf ~/.config/cursor/index.theme ~/.icons/default/
ln -sf ~/.config/tmux.conf ~/.tmux.conf
ln -sf ~/.config/X11/clientrc ~/.xinitrc
ln -sf ~/.config/X11/serverrc ~/.xserverrc
ln -sf ~/.config/X11/resources ~/.Xresources
ln -sf ~/.config/X11/profile ~/.xprofile
ln -sf ~/.config/X11/session ~/.xsession
ln -sf ~/.config/matlabrc.m ~/Documents/MATLAB/startup.m
rm -rf ~/.local/share/applications
ln -sf ~/.config/applications ~/.local/share/applications
read -rsp $'Press any key to continue...\n' -n1 key

# Neovim
echo '[config-install]==> Setting up neovim...'
pip install --user neovim
pip install --user neovim-remote
pip install --user pexpect
pip2 install --user neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
read -rsp $'Press any key to continue...' -n1 key

# ZIM
if [ ! -e "${HOME}/.config/zsh/zimfw" ] ; then
    echo '[config-install]==> Setting up ZIM...\n'
    git clone --recursive https://github.com/zimfw/zimfw ~/.config/zsh/zimfw
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k
    ln -s ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme ~/.config/zsh/zimfw/modules/prompt/functions/prompt_powerlevel9k_setup
    read -rsp $'Press any key to continue...' -n1 key
fi

# Dropbox
echo '[config-install]==> Preventing dropbox auto updates...'
[ -d ~/.dropbox-dist ] && rm -rf ~/.dropbox-dist
install --mode 0 --directory ~/.dropbox-dist

# Steam
echo '[config-install]==> Cloning steam theme...'
mkdir -p ~/.local/share/Steam/skins
git clone https://github.com/airforsteam/Air-for-Steam.git ~/.local/share/Steam/skins/Air

# Thunderbird
if [ -d ~/.thunderbird ] ; then
    echo '[config-install]==> Cloning thunderbird theme...'
    _folder="${HOME}/.thunderbird/$(ls ~/.thunderbird | grep default)/chrome"
    git clone https://github.com/spymastermatt/thunderbird-monterail.git "${_folder}"
    sed -i 's|^/\* @import "icons/darkIcons.css"|@import "icons/darkIcons.css"|g' "${_folder}/userChrome.css"
fi

# Generating dynamic files
echo '[config-install]==> Generating dynamic files, will need root...'
~/.config/i3/parse_config.sh
~/.config/isync/passgen.sh
~/.config/mpdscribble-confgen.sh
~/.config/vdirsyncer/passgen.sh
~/.config/s3cfg-gen.sh
~/.config/piagen.sh
