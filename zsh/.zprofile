# Import .local/bin
if [ -d "$HOME/.local/bin" ]
then
    PATH="$HOME/.local/bin:$PATH"
fi
# import vim-live-latex
if [ -d "$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin" ]
then
    PATH="$XDG_CONFIG_HOME/nvim/bundle/vim-live-latex-preview/bin:$PATH"
fi

# Start things
if   [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq  1 ]
then
    exec startx
fi
