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
Plug 'junegunn/fzf.vim'
" Git status
Plug 'airblade/vim-gitgutter'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Autocomplete for programming
Plug 'ervandew/SuperTab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
" Linting (code checking)
Plug 'w0rp/ale'
" Snippets (code snippet inserter)
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Ctags manager
Plug 'ludovicchabant/vim-gutentags'
" Matlab editor
Plug 'daeyun/vim-matlab', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-scripts/MatlabFilesEdition'
" LaTeX editing
Plug 'lervag/vimtex'
Plug 'mhinz/neovim-remote'
" Grammar checker
Plug 'rhysd/vim-grammarous'
" Config file types
Plug 'mboughaba/i3config.vim'
Plug 'aouelete/sway-vim-syntax'
Plug 'baskerville/vim-sxhkdrc'
"" Gentoo syntax
Plug 'gentoo/gentoo-syntax'
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
set number                  " Show line numbers
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
set spelllang=en_us                                 " Turn on spellcheck
set colorcolumn=80                                  " Highlight 80th column
set laststatus=2                                    " Always show status bar
set updatetime=500                                  " Plugin update time >4s
set mouse=a                                         " Disable mouse click
set splitbelow              " Horizontal splitsgo down
set splitright              " Vertical splits go right
set showtabline=2           " For airline on top
let g:grammarous#languagetool_cmd = 'languagetool'  " Grammar check
let g:is_posix = 1


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

"-----Keymapping-----"
let mapleader="\<Space>"
" map leader+s to search and replace
nmap <leader>s :%s//g<Left><Left>
" Clear search higlights with Ctrl Q
nnoremap <silent> <C-Q> :nohlsearch<CR>
" Toggle line numbering mode
nnoremap <leader>n :call NumberToggle()<cr>
" Remap accidental ; presses to :
nnoremap ; :
" Navigate splits easier
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>l <C-w><C-l>
nnoremap <leader>h <C-w><C-h>
" make command
nnoremap <F5> :make<CR>
" Regular cut-copy-paste
vnoremap <C-x> "+x
vnoremap <C-c> "+y
noremap <C-v> "+p

"---------------------------------"
"  __                             "
" /__ o _|_  _     _|_ _|_  _  ._ "
" \_| |  |_ (_| |_| |_  |_ (/_ |  "
"            _|                   "
"---------------------------------"
" Hunks are  blocks of change in code.
" Move between git hunks using [c and ]c
"   <leader>hp : Preview change
"   <leader>hs : Stage (commit) change
"   <leader>hu : Undo (commit) change
let g:gitgutter_max_signs=1000      " Don't show if too many changes
let g:gitgutter_sign_added = ''
let g:gitgutter_sign_modified = ''
let g:gitgutter_sign_removed = ''
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''

"-----------------------"
"                       "
"  /\  o ._ | o ._   _  "
" /--\ | |  | | | | (/_ "
"                       "
"-----------------------"

"-----Colorscheme------"
let g:airline_theme='base16'        " Airline theme
let g:airline_powerline_fonts=1     " Force powerline fonts
let g:airline_statusline_ontop=1    " Put airline on top
let g:airline#extensions#ale#enabled=1
let g:airline#extensions#gutentags#enabled=1

"------------------------------"
"  _                           "
" | \  _   _  ._  |  _ _|_  _  "
" |_/ (/_ (_) |_) | (/_ |_ (/_ "
"             |                "
"------------------------------"
" Deoplete is autocompletion engine
"   Press tab to open autocompletion menu, and tab to navigate.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('auto_complete', v:false)
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
call deoplete#custom#source('ale', 'rank', 1)


let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabClosePreviewOnPopupClose = 1

"------------------------------"
"              __              "
" | | | _|_ o (_  ._  o ._   _ "
" |_| |  |_ | __) | | | |_) _> "
"                       |      "
"------------------------------"
" Macro parser
let g:UltiSnipsExpandTrigger="<C-j>"
"   Use Ctrl + hl to move through units
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"

"------------"
"            "
"  /\  |  _  "
" /--\ | (/_ "
"            "
"------------"
" Linter (syntax and warning checker) and fixing
"   Use Ctrl + jk to move back/forth between errors
let g:ale_sign_column_always=1
let g:ale_sign_error=''
let g:ale_sign_warning=''
let g:ale_set_hightlights = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

"----------------------------------"
"  __                              "
" /__    _|_  _  ._ _|_  _.  _   _ "
" \_| |_| |_ (/_ | | |_ (_| (_| _> "
"                            _|    "
"----------------------------------"
" Tag file generator (index of objects of interest)
let g:gutentags_enabled=1
let g:gutentags_generate_on_missing=1

"----------"
"  _     _ "
" |_ _ _|_ "
" |  /_ |  "
"          "
"----------"
" Fuzzy file finder

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~20%' }
let g:fzf_history_dir = '~/.cache/fzf-history'

" Open files in vertical horizontal split
nnoremap <silent> <Leader>f :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>

"---------------------------------------"
"                                       "
" \  / o ._ _ __ |\/|  _. _|_ |  _. |_  "
"  \/  | | | |   |  | (_|  |_ | (_| |_) "
"                                       "
"---------------------------------------"
" (Mostly) Syntax highlighting for matlab
let g:matlab_auto_mappings = 0          "automatic mappings disabled
let g:matlab_server_split = 'vertical'  "launch the server in a vertical split
let g:matlab_server_launcher = 'tmux'   "launch the server in a tmux split

"-----------------"
"       ___       "
" |   _. |  _  \/ "
" |_ (_| | (/_ /\ "
"                 "
"-----------------"
" Compiling LaTeX
"   On Zathura, Ctrl click will go to selected line in nvim
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_method = 'latexmk'
let g:tex_flavor = 'latex'

"----------------------------------------"
"  __                                    "
" /__ ._ _. ._ _  ._ _   _. ._ _       _ "
" \_| | (_| | | | | | | (_| | (_) |_| _> "
"                                        "
"----------------------------------------"
" Grammar check
let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }
