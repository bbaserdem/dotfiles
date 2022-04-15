"-----------------"
"-----PLUGINS-----"
"-----------------"

" Bootstrap Plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  augroup installVimPlug
    " Make sure we run only once
    if !exists('installVimPlug_loaded')
      let installVimPlug_loaded = 1
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
  augroup END
endif
unlet autoload_plug_path

call plug#begin('$XDG_DATA_HOME/nvim/plugged')
" Colorscheme
Plug 'chriskempson/base16-vim'
" Indentation tracker
Plug 'Yggdroot/indentLine'
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
" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-clang'
" Ctags manager
"Plug 'ludovicchabant/vim-gutentags'
" Snippets (code snippet inserter)
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Linting (code checking)
Plug 'dense-analysis/ale'
" LaTeX editing
Plug 'lervag/vimtex'
" Grammar checker
Plug 'rhysd/vim-grammarous'
" Config file types
Plug 'aouelete/sway-vim-syntax'
Plug 'bbaserdem/musicbrainz-vim-syntax', { 'branch': 'main' }
Plug 'baskerville/vim-sxhkdrc'
Plug 'gentoo/gentoo-syntax'
Plug 'brgmnn/vim-syncthing'
Plug 'vim-scripts/MatlabFilesEdition'
call plug#end()

"------------"
"---CONFIG---"
"------------"

"---Base16---"
" Fix for ANSI terminal colorscheme; should work with most terminals
let base16colorspace=256

"---VimGrammarous---"
" Check only comments; except these file types
let g:grammarous#default_comments_only_filetypes = {
        \ '*' : 1,
        \ 'help' : 0,
        \ 'markdown' : 0,
        \ 'latex' : 0,
        \ }
" Use vim defaults
let g:grammarous#use_vim_spelllang = 1
" Use system languagetool
let g:grammarous#languagetool_cmd = 'languagetool'
" Show the first error while languagetool is working
let g:grammarous#show_first_error = 1

"---indentLine---"
" Indentline breaks latex highlighting for some reason
let g:indentLine_conceallevel = 0

"---FuzzyFinder---"
" Prefix commands with Fzf
let g:fzf_command_prefix = 'Fzf'

"---NERDTree---"
" For automatically launching nerdtree at startup; enable this line
" autocmd vimenter * NERDTree
" Close nvim if nerdtree is the last window
" autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
"let g:airline_statusline_ontop=1
" Enable lint extension
let g:airline#extensions#ale#enabled=1
" Enable tabline for listing buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
" Enable ctags extension
"let g:airline#extensions#gutentags#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" Left sections
"g:airline_section_a = ''
"g:airline_section_b = ''
" Midsection
"g:airline_section_c = ''
" Right section
"g:airline_section_x = ''
"g:airline_section_y = ''
"g:airline_section_z = ''

"---Deoplete---"
" Enable/disable it as I'm typing
let g:deoplete#enable_at_startup=1
" Limit matches
call deoplete#custom#option('max_list', 100)

"---Ale---"
" Always keep the gutter line open
let g:ale_sign_column_always=1
" No highlights
"let g:ale_set_highlights = 0
" Add Ale autocompletion to deoplete
call deoplete#custom#source('ale', 'rank', 999)
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
" Make sure we know who is complaining
let g:ale_echo_msg_format = '%linter% says %s'

"---Vimtex---"
" Compiler to use
let g:vimtex_compiler_method='latexmk'
" Use neovim-remote for callback functionality
let g:vimtex_compiler_progname = 'nvr'
" Make sure tex files are detected as latex, and not plaintex
let g:tex_flavor='latex'
" Use YaLafi to grammar check using languagetools
let g:vimtex_grammar_vlty = {'lt_command': 'languagetool'}
