set nocompatible
filetype off
syntax on


""""""" Plugin management stuff """""""
set rtp+=$XDG_CONFIG_HOME/nvim/bundle/Vundle.vim
call vundle#begin('$XDG_CONFIG_HOME/nvim/bundle')
Plugin 'VundleVim/Vundle.vim'
" Colorscheme
Plugin 'chriskempson/base16-vim'
" Neomake build tool (mapped below to <c-b>)
Plugin 'neomake/neomake'
" Autocomplete for programming
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
" LaTeX editing
Plugin 'lervag/vimtex'
Plugin 'mhinz/neovim-remote'
" Status bar mods
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
" I3 vim
Plugin 'PotatoesMaster/i3-vim-syntax'
" Matlab file editor
Plugin 'daeyun/vim-matlab'
" NERDtree file browser
Plugin 'scrooloose/nerdtree'
" Grammar checker
Plugin 'rhysd/vim-grammarous'
" After all plugins...
call vundle#end()
filetype plugin indent on

""""""" Colorscheme """""""
let base16colorspace=256
"colorscheme base16-default-dark
"colorscheme base16-eighties
"colorscheme base16-material
"colorscheme base16-nord
"colorscheme base16-ocean
colorscheme base16-onedark
"colorscheme base16-railscasts
"colorscheme base16-tomorrow-night
"colorscheme base16-bright
"colorscheme base16-classic-dark
"colorscheme base16-default-dark


""""""" NERDTree """""""
map <C-r> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


""""""" General coding stuff """""""
" Turn on spellcheck
set spelllang=en_us
" Grammar check
let g:grammarous#languagetool_cmd = 'languagetool'
" Highlight 80th column
set colorcolumn=80
" Always show status bar
set laststatus=2
" Let plugins show effects after 500ms, not 4s
set updatetime=500
" Disable mouse click to go to position
set mouse=a
" Don't let autocomplete affect usual typing habits
set completeopt=menuone,preview,noinsert
" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000


""""""" C stuff """"""
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

""""""" Python stuff """""""
syntax enable
set number showmatch
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
let python_highlight_all = 1

""""""" Matlab Stuff """""""
let g:matlab_server_launcher = 'vim'
let g:matlab_server_split = 'vertical'

""""""" LaTeX Stuff """""""
let g:vimtex_compiler_progname = 'nvr'

""""""" Keybindings """""""
" Set up leaders
let mapleader=","
let maplocalleader="\\"

" Cut and paste commands
vnoremap <C-x> "+x
vnoremap <C-c> "+y
noremap <C-v> "+p

" Navigate splits easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>
autocmd BufNewFile,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r !make<cr>:setlocal buftype=nofile<cr>:setlocal bufhidden=hide<cr>:setlocal noswapfile<cr>
autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>

" disables opaque background                                                
