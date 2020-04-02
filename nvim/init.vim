"    _   __                _              ______            _____
"   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
"  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
" / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
"/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
"                                                             /____/

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

call plug#begin('$XDG_DATA_HOME/nvim/plugged')
" Colorscheme
Plug 'chriskempson/base16-vim'
" File browser(s)
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
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

"-----------------"
"-----OPTIONS-----"
"-----------------"

"-----Base settings-----"
set cmdheight=1             " Command bar height
set number                  " Show line number on current line
set relativenumber          " Show relative numbers on other lines
set showmatch               " Show matching brackets
set formatoptions+=o        " Continue comment marker in new lines.
set colorcolumn=80          " Highlight 80th column
set laststatus=2            " Always show status bar
set updatetime=5000         " Swap file after this many milliseconds
set splitbelow              " Horizontal splits are put below
set splitright              " Vertical splits are put on the right
set mouse=a                 " Enable mouse click
set ignorecase              " Make searching case insensitive
set smartcase               " ... unless the query has capital letters.
set scrolloff=5             " Make it so there are always lines below the cursor
set wildignore=*.o,*~,*.pyc " Ignore these files in completion/search

"-----Indentation-----"
" Double press of > and < will increase or decrease indentation
set autoindent              " Allow autoindent
set expandtab               " Insert spaces when TAB is pressed.
set tabstop=8               " Render TABs using this many spaces.
set softtabstop=4
set shiftwidth=4            " Indentation amount for < and > commands.
set nojoinspaces            " Prevents inserting two spaces after punctuation on a join (J)
set spelllang=en,tr         " Turn on spellcheck
set showtabline=2           " For airline on top
set linebreak               " Break long lines at 
set breakindent             " Wrapped lines will retain indentation
let &showbreak='↪'          " Put character at the beginning of wrapped lines

" Tell Vim which characters to show for expanded TABs,
if &listchars ==# 'eol:$'
  set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+
endif
"set list                " Show problematic characters.

" Function to toggle numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

"------------------"
"-----Keybinds-----"
"------------------"
let mapleader="\<Space>"            " Leader key for external
" Search and replace
nmap <leader>s :%s//g<Left><Left>
" Clear search highlight
nnoremap <silent> <C-Q> :nohlsearch<CR>
" Spilt navigation
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>l <C-w><C-l>
nnoremap <leader>h <C-w><C-h>
" Copy paste functionality with the clipboard
noremap <C-x> "+x
noremap <C-c> "+y
noremap <C-v> "+p
" Fzf File finder when pressing space+f
nnoremap <silent> <Leader>f :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>
" Switch back and forth with nerdtree when pressing space + ctrl-n
map <Leader>n :NERDTreeFocus<CR>
map <Leader><C-n> :NERDTreeToggle<CR>


"----------------"
"-----COLORS-----"
"----------------"
let base16colorspace=256
colorscheme base16-onedark

let g:grammarous#languagetool_cmd = 'languagetool'  " Grammar check
let g:is_posix = 1

"----------------------"
"-----FILE BROWSER-----"
"----------------------"
"NerdTREE
autocmd vimenter * NERDTree     " Automatically launch Nerdtree
