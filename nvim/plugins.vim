"-----------------"
"-----PLUGINS-----"
"-----------------"

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin('$XDG_DATA_HOME/nvim/plugged')
" Colorscheme
Plug 'chriskempson/base16-vim'
" File browser(s)
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
" Git management
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Uniting tab completion
Plug 'ervandew/supertab'
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-clang'
" Linting (code checking)
"Plug 'dense-analysis/ale'
" Snippets (code snippet inserter)
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
" Ctags manager
"Plug 'ludovicchabant/vim-gutentags'
" Matlab editor
"Plug 'daeyun/vim-matlab', { 'do': ':UpdateRemotePlugins' }
"Plug 'vim-scripts/MatlabFilesEdition'
" LaTeX editing
"Plug 'lervag/vimtex'
"Plug 'mhinz/neovim-remote'
" Grammar checker
"Plug 'rhysd/vim-grammarous'
" Config file types
"Plug 'mboughaba/i3config.vim'
"Plug 'aouelete/sway-vim-syntax'
"Plug 'baskerville/vim-sxhkdrc'
"Plug 'gentoo/gentoo-syntax'
" After all plugins...
call plug#end()

"------------"
"---CONFIG---"
"------------"

"---Base16---"
" Fix for ANSI terminal colorscheme; should work with most terminals
let base16colorspace=256

"---NERDTree---"
" For automatically launching nerdtree at startup; enable this line
"autocmd vimenter * NERDTree
" Close nvim if nerdtree is the last window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"---Gitgutter---"
" Maximum amount to show
let g:gitgutter_max_signs = 1000
" Show changes in folded lines
set foldtext=gitgutter#fold#foldtext()

"---Airline---"
" Force powerline fonts
let g:airline_powerline_fonts=1
" Have on top bar
set showtabline=2
let g:airline_statusline_ontop=1
" Enable lint extension
let g:airline#extensions#ale#enabled=1
" Enable ctags extension
let g:airline#extensions#gutentags#enabled=1

"---Deoplete---"
let g:deoplete#enable_at_startup = 1
