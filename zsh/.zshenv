# Set XDG_CONFIG_HOME
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_DATA_DIRS="/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"

export XINITRC="${XDG_CONFIG_HOME}/X11/clientrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/serverrc"
# This causes the desktop to not load
# export XAUTHORITY="${XDG_RUNTIME_DIR}/Xauthority"

# Import Path
[ -d "${HOME}/.local/bin" ] && PATH="${HOME}/.local/bin:${PATH}"
[ -d "${XDG_CONFIG_HOME}/scripts" ] && PATH="${XDG_CONFIG_HOME}/scripts:${PATH}"
# import vim-live-latex
if [ -d "${XDG_CONFIG_HOME}/nvim/bundle/vim-live-latex-preview/bin" ]
then
    PATH="${XDG_CONFIG_HOME}/nvim/bundle/vim-live-latex-preview/bin:${PATH}"
fi

# Z directory
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
# ZIM stuff
export ZIM_HOME="${ZDOTDIR}/zimfw"

# GPG public key
export GPGKEY=0B7151C823559DD8A7A04CE36426139E2F4C6CCE
# Pinentry
export GPG_TTY=$(tty)
if [[ -n "$SSH_CONNECTION" ]] ;then
    export PINENTRY_USER_DATA="USE_CURSES=1"
fi

# Password store location
export PASSWORD_STORE_DIR="${HOME}/.pass"
export PASSWORD_STORE_GIT="${HOME}/.pass"

# Compile in parallel using AUR
export MAKEFLAGS="-j$(nproc)"

# Just MATLAB things
# One day . . . one day MATLAB will actually do what I want it to do . . .
export MATLAB_DIR="/opt/matlab"
export MATLAB_LOG_DIR="${XDG_CACHE_HOME}/matlab/"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
export _JAVA_AWT_WM_NONREPARENTING=1
# export MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre
[ -f "/usr/lib/libstdc++.so" ] && [ -f "/usr/lib/libfreetype.so.6" ] && export LD_PRELOAD="/usr/lib/libstdc++.so:/usr/lib/libfreetype.so.6"
# export LD_LIBRARY_PATH=/usr/lib/xorg/modules/dri/
export OCTAVE_HISTFILE="${XDG_CACHE_HOME}/octave-hsts"
export OCTAVE_SITE_INITFILE="${XDG_CONFIG_HOME}/octave/octaverc"

# Monitors
if [[ $(hostname) == 'sbplaptop' ]]
then
    export MON_0="eDP"
    export BRI_SCR="amdgpu_bl0"
    export BRI_KBD="asus::kbd_backlight"
elif [[ $(hostname) == 'sbpnotebook' ]]
then
    export MON_0="eDP-1"
    export BRI_SCR="intel_backlight"
    export BRI_KBD="asus::kbd_backlight"
elif [[ $(hostname) == 'sbpworkstation' ]]
then
    export MON_0="DP-2"
    export BRI_SCR=""
    export BRI_KBD=""
elif [[ $(hostname) == 'sbpserver' ]]
then
    export MON_0="HDMI-2"
    export BRI_SCR=""
    export BRI_KBD=""
fi

# Rofi-pass config
export ROFI_PASS_CONFIG="${XDG_CONFIG_HOME}/rofi/pass.conf"
# Android studio
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
# GPG config
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
# QT5 theme
export QT_STYLE_OVERRIDE="kvantum"
export QT_QPA_PLATFORMTHEME="kvantum"
# GTK stuff
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
# Jupyter
export IPYTHONDIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
# Set neovim as editor
export EDITOR="/usr/bin/nvim"
# Set qutebrowser as browser
export BROWSER="/usr/bin/qutebrowser"
# Set terminal to use for launching
export TERMINAL="/usr/bin/termite"
# Notmuch
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/neomutt/notmuch-config"
# OpenFOAM
export FOAM_INST_DIR="/opt/OpenFOAM"
# Weechat
export WEECHAT_HOME="${XDG_CONFIG_HOME}/weechat"
# SXHKD
export SXHKD_SHELL="/usr/bin/sh"
# Taskwarrior
export TASKRC="${XDG_CONFIG_HOME}/taskrc"
export TASKDATA="${HOME}/Documents/Tasks/"
export TIMEWARRIORDB="${HOME}/Documents/Tasks/"
# Tmux
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
# Wine
export WINEPREFIX="/opt/wine"
# Vimperator
export VIMPERATOR_INIT=":source ${XDG_CONFIG_HOME}/vimperator/vimperatorrc"
export VIMPERATOR_RUNTIME="${XDG_CONFIG_HOME}/vimperator"
# VIFM
export VIFM="${XDG_CONFIG_HOME}/vifm"
export MYVIFMRC="${VIFM}/vifmrc"
# ZSH
export HISTFILE="${XDG_DATA_HOME}/zsh/history"

# Status bar colors: base16-default-dark
export base00='#181818'
export base01='#282828'
export base02='#383838'
export base03='#585858'
export base04='#b8b8b8'
export base05='#d8d8d8'
export base06='#e8e8e8'
export base07='#f8f8f8'
export base08='#ab4642'
export base09='#dc9656'
export base0A='#f7ca88'
export base0B='#a1b56c'
export base0C='#86c1b9'
export base0D='#7cafc2'
export base0E='#ba8baf'
export base0F='#a16946'
