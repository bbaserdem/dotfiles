# Import .local/bit
if [ -d "$HOME/.local/bin" ]
then
    PATH="$HOME/.local/bin:$PATH"
fi
# import vim-live-latex
if [ -d "$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin" ]
then
    PATH="$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin:$PATH"
fi

# Load some environment variables to systemd
systemctl --user import-environment XDG_CONFIG_HOME 
systemctl --user import-environment MON_0
systemctl --user import-environment MON_1
systemctl --user import-environment BRI_SCR
systemctl --user import-environment BRI_KBD

# Start things
if   [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  1 ]
then
    # Set cursor theme
    exec startx
fi
