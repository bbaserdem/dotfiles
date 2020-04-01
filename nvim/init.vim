"    _   __                _              ______            _____
"   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
"  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
" / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
"/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
"                                                             /____/
" Use Bigfig ascii art

"-----Required-----"
set nocompatible
filetype off
syntax on
set encoding=utf-8

"------------------------"
"  _                     "
" |_) |      _  o ._   _ "
" |   | |_| (_| | | | _> "
"            _|          "
"------------------------"

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
" Colorscheme
Plug 'chriskempson/base16-vim'
" Fuzzy file finder
"Plug 'junegunn/fzf.vim'
" Git status
"Plug 'airblade/vim-gitgutter'
" Status bar
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
" Completion
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'deoplete-plugins/deoplete-jedi'
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

"-------------------------"
"  _                      "
" / \ ._ _|_ o  _  ._   _ "
" \_/ |_) |_ | (_) | | _> "
"     |                   "
"-------------------------"
let base16colorspace=256
colorscheme base16-onedark

"-----Base stuff-----"
set cmdheight=1             " Command bar height
set number                  " Show line numbers
set relativenumber          " Show line numbers
set showmatch               " Show matching brackets
set formatoptions+=o        " Continue comment marker in new lines.
set autoindent              " Allow autoindent
set expandtab               " Insert spaces when TAB is pressed.
set tabstop=4               " Render TABs using this many spaces.
set softtabstop=4
set shiftwidth=4            " Indentation amount for < and > commands.
set nojoinspaces            " Prevents inserting two spaces after punctuation on a join (J)
set ignorecase              " Make searching case insensitive
set smartcase               " ... unless the query has capital letters.
set spelllang=en_us,tr_tr                           " Turn on spellcheck
set colorcolumn=80                                  " Highlight 80th column
set laststatus=2                                    " Always show status bar
set updatetime=500                                  " Plugin update time >4s
set mouse=a                                         " Disable mouse click
set splitbelow              " Horizontal splitsgo down
set splitright              " Vertical splits go right
set showtabline=2           " For airline on top
set scrolloff=16            " Make it so there are always lines below my cursor
set wildignore=*.o,*~,*.pyc " Ignore compiled files
let g:grammarous#languagetool_cmd = 'languagetool'  " Grammar check
let g:is_posix = 1
" Make it so that long lines wrap smartly
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak

" Tell Vim which characters to show for expanded TABs,
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
"set list                " Show problematic characters.

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc
