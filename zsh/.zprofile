# Import scripts path
if [ -d "$XDG_CONFIG_HOME/scripts" ]; then
    PATH="$XDG_CONFIG_HOME/scripts:$PATH"
fi
# Import .local/bit
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi
# import vim-live-latex
if [ -d "$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin" ]; then
    PATH="$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin:$PATH"
fi

# Import variables into systemd
systemctl --user import-environment {HOME,XDG_CONFIG_HOME,PATH}

# Start i3
if   [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  1 ]
then
    exec startx $XDG_CONFIG_HOME/login/bspwm.sh
fi
