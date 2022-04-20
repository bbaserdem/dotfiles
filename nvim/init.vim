"    _   __                _              ______            _____
"   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
"  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
" / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
"/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
"                                                             /____/

"---Required---"
syntax on
set encoding=utf-8
if $TERM ==? 'linux'
  let isConsole = 1
else
  let isConsole = 0
endif

"---External config options---"
source $XDG_CONFIG_HOME/nvim/plugins.vim
source $XDG_CONFIG_HOME/nvim/keybinds.vim
if isConsole
  source $XDG_CONFIG_HOME/nvim/noglyph.vim
else
  source $XDG_CONFIG_HOME/nvim/glyph.vim
endif

"---Color scheme---"
set termguicolors
colorscheme vscode

"---Base settings---"
set cmdheight=2             " Command bar height
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
set cursorcolumn            " Highlight current column
set cursorline              " Highlight current line
set autoread                " Reload changed files
set conceallevel=0          " Don't conceal any characters
set timeoutlen=3000         " Make mapping sequences timeout in 3 secs instead
set ttimeoutlen=100         " But don't extrapolate to keycodes
set showtabline=2           " Always show tabs
"set complete=               " Disable built in autocomplete

"---Indentation---"
" Double press of > and < will increase or decrease indentation
set autoindent              " Allow autoindent
set expandtab               " Insert spaces when TAB is pressed.
set tabstop=8               " Render TABs using this many spaces.
set softtabstop=4
set shiftwidth=4            " Indentation amount for < and > commands.
set nojoinspaces            " Prevents inserting two spaces after punctuation on a join (J)
set spelllang=en_us         " Turn on spellcheck
set linebreak               " Break long lines at
set breakindent             " Wrapped lines will retain indentation

" Function to toggle numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunc

"---Tab menu---"
" Tell Vim which characters to show for expanded TABs,
if &listchars ==# 'eol:$'
  set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:+
endif
"set list                " Show problematic characters.
