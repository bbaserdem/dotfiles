"    _   __                _              ______            _____
"   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
"  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
" / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
"/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
"                                                             /____/

"---Required---"
syntax on
if $TERM ==? 'linux'
  let isConsole = 1
  source $XDG_CONFIG_HOME/nvim/noglyph.vim
else
  let isConsole = 0
  source $XDG_CONFIG_HOME/nvim/glyph.vim
endif

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
