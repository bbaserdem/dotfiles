#!/usr/bin/sh
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR
IF=$'\n\t'

# Place symlinks
echo '[config-install]==> Symlinking...\n'
mkdir -p ~/Documents/MATLAB
mkdir -p ~/.local/share
mkdir -p ~/.cache/mpd
ln -sf ~/.config/abcde.conf ~/.abcde.conf
ln -sf ~/.config/bash/bashrc ~/.bashrc
ln -sf ~/.config/bash/login ~/.bash_profile
ln -sf ~/.config/bash/logout ~/.bash_logout
ln -sf ~/.config/gtk2rc ~/.gtkrc-2.0
ln -sf ~/.config/tmux.conf ~/.tmux.conf
ln -sf ~/.config/zsh/zshenv ~/.zshenv
ln -sf ~/.config/X11/clientrc ~/.xinitrc
ln -sf ~/.config/X11/serverrc ~/.xserverrc
ln -sf ~/.config/X11/resources ~/.Xresources
ln -sf ~/.config/octave/octaverc ~/.octaverc
ln -sf ~/.config/matlabrc.m ~/Documents/MATLAB/startup.m
ln -sf ~/.config/applications ~/.local/share/applications
read -rsp $'Press any key to continue...\n' -n1 key

# Neovim
echo '[config-install]==> Setting up neovim...'
pip install --user neovim
pip install --user neovim-remote
pip install --user pexpect
pip2 install --user neovim
[ -e '~/.config/nvim/bundle' ] || mkdir ~/.config/nvim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
nvim +PluginInstall +qall

~/.config/nvim/bundle/YouCompleteMe/install.py --clang-completer --system-libclang
read -rsp $'Press any key to continue...' -n1 key

# ZIM
echo '[config-install]==> Setting up ZIM...\n'
git clone --recursive https://github.com/zimfw/zimfw ~/.config/zsh/zimfw
git clone https://github.com/bhilburn/powerlevel9k.git ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k
ln -s ~/.config/zsh/zimfw/modules/prompt/external-themes/powerlevel9k/powerlevel9k.zsh-theme ~/.config/zsh/zimfw/modules/prompt/functions/prompt_powerlevel9k_setup
read -rsp $'Press any key to continue...' -n1 key

# Dropbox
echo '[config-install]==> Preventing dropbox auto updates...'
[ -d ~/.dropbox-dist ] && rm -rf ~/.dropbox-dist
install --mode 0 --directory ~/.dropbox-dist
# Generating dynamic files
echo '[config-install]==> Generating dynamic files, will need root...'
~/.config/i3/parse_config.sh
~/.config/isync/passgen.sh
~/.config/mpdscribble-confgen.sh
~/.config/vdirsyncer/passgen.sh
~/.config/s3cfg-gen.sh
~/.config/piagen.sh
