"    _   __                _              ______            _____
"   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
"  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
" / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
"/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
"                                                             /____/

"---Required---"
set nocompatible
filetype off
syntax on
set encoding=utf-8

"---External config options---"
source plugins.vim
source theme.vim
source keybinds.vim

"---Base settings---"
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

"---Indentation---"
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
" Function to toggle numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

"---Tab menu---"
" Tell Vim which characters to show for expanded TABs,
if &listchars ==# 'eol:$'
  set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+
endif
"set list                " Show problematic characters.




"------------"
"---COLORS---"
"------------"
let base16colorspace=256
colorscheme base16-onedark

let g:grammarous#languagetool_cmd = 'languagetool'  " Grammar check
let g:is_posix = 1

"------------------"
"---FILE BROWSER---"
"------------------"
"NerdTREE
" For automatically launching nerdtree at startup
"autocmd vimenter * NERDTree
" Close nvim if nerdtree is the last window
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"----------------"
"---STATUS BAR---"
"----------------"
" Airline
let g:airline_theme='base16'
let g:airline_powerline_fonts=1
let g:airline_statusline_ontop=1
"let g:airline#extensions#ale#enabled=1
"let g:airline#extensions#gutentags#enabled=1


