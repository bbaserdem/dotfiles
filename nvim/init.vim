"-----Required-----"
set nocompatible
filetype off
syntax on



"-----Plugin management-----"
set rtp+=$XDG_CONFIG_HOME/nvim/bundle/Vundle.vim
call vundle#begin('$XDG_CONFIG_HOME/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'
" Colorscheme
Plugin 'chriskempson/base16-vim'
" NERDtree file browser
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
" Status bar mods
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
" Autocomplete for programming
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
" Linting
Plugin 'w0rp/ale'
" Tags (What is this?)
" Plugin 'ludovicchabant/vim-gutentags'
" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Matlab editor
Plugin 'daeyun/vim-matlab'
Plugin 'vim-scripts/MatlabFilesEdition'
" LaTeX editing
Plugin 'mhinz/neovim-remote'
Plugin 'lervag/vimtex'
" I3 vim
Plugin 'PotatoesMaster/i3-vim-syntax'
" Python highlighting
" Plugin 'numirias/semshi'
" Grammar checker
Plugin 'rhysd/vim-grammarous'
" After all plugins...
call vundle#end()
filetype plugin indent on



"-----Colorscheme------"

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
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set spelllang=en_us                                 " Turn on spellcheck
let g:grammarous#languagetool_cmd = 'languagetool'  " Grammar check
set colorcolumn=80                                  " Highlight 80th column
set laststatus=2                                    " Always show status bar
set updatetime=500                                  " Plugin update time >4s
set mouse=a                                         " Disable mouse click
set splitbelow              " Natural splits
set splitright

" Tell Vim which characters to show for expanded TABs,
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

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
nmap <leader>s :%s//g<Left><Left>
nnoremap <silent> <C-Q> :nohlsearch<CR>
nnoremap <leader>n :call NumberToggle()<cr>
nnoremap ; :
" Navigate splits easier
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>l <C-w><C-l>
nnoremap <leader>h <C-w><C-h>
map <leader>r :NERDTreeToggle<CR>
nmap ]g <Plug>GitGutterNextHunk
nmap [g <Plug>GitGutterPrevHunk
map <leader>yg :YcmGenerateConfig<CR>
nnoremap <F5> :make<CR>
vnoremap <buffer>         <leader>mm <ESC>:MatlabLaunchServer<CR>
vnoremap <buffer><silent> <leader>ms <ESC>:MatlabCliRunSelection<CR>
nnoremap <buffer><silent> <leader>m<S-s> <ESC>:MatlabCliRunCell<CR>
nnoremap <buffer><silent> <leader>ml :MatlabCliRunLine<CR>
nnoremap <buffer><silent> <leader>mv <ESC>:MatlabCliViewVarUnderCursor<CR>
nnoremap <buffer><silent> <leader>mh  <ESC>:MatlabCliHelp<CR>
nnoremap <buffer><silent> <leader>me <ESC>:MatlabCliOpenInMatlabEditor<CR>
nnoremap <buffer><silent> <leader>mc :MatlabCliCancel<CR>
vnoremap <C-x> "+x
vnoremap <C-c> "+y
noremap <C-v> "+p



"-----NERDTree-----"
" Nerdtree opens if vim launched with no arguments or at a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Exit vim if only window remaining is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Limit NERDTree highlighting to used filetypes
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1
let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'js', 'css', 'mat']
" Show hidden files
let NERDTreeShowHidden=1



"-----Status Bar-----"
let g:airline_theme='base16'       " Airline theme
let g:gitgutter_max_signs=1000      " Don't show if too many changes
let g:gitgutter_map_keys = 0        " Don't do remapping keys
let g:gitgutter_sign_added = ' '
let g:gitgutter_sign_modified = ' '
let g:gitgutter_sign_removed = ' '
let g:gitgutter_sign_removed_first_line = ''
let g:gitgutter_sign_modified_removed = ''



"-----YouCompleteMe-----"
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'



"-----Linting-----"
let g:ale_sign_column_always = 1



"-----Snippets-----"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"



"-----Matlab-----"
let g:matlab_server_launcher = 'tmux'   "Doesn't work?
let g:matlab_server_split = 'vertical'  "Matlab splits should be vertical
let g:matlab_auto_mappings = 0          "automatic mappings disabled



"-----LaTeX-----"
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_compiler_method = 'arara'
let g:tex_flavor = 'latex'
