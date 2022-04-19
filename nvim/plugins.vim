"-----------------"
"-----PLUGINS-----"
"-----------------"

" Bootstrap Vim-Plug
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
" Lua stuff
Plug 'nvim-lua/plenary.nvim'                , {'branch': 'master' }
" Colorscheme
Plug 'chriskempson/base16-vim'              , {'branch': 'master' }
" Indentation tracker
Plug 'lukas-reineke/indent-blankline.nvim'  , {'branch': 'master' }
" File browser(s)
Plug 'junegunn/fzf.vim'                     , {'branch': 'master' }
Plug 'preservim/nerdtree'                   , {'branch': 'master' }
Plug 'Xuyuanp/nerdtree-git-plugin'          , {'branch': 'master' }
Plug 'ryanoasis/vim-devicons'               , {'branch': 'master' }
" Git management
Plug 'airblade/vim-gitgutter'               , {'branch': 'master' }
Plug 'tpope/vim-fugitive'                   , {'branch': 'master' }
" Status bar
Plug 'vim-airline/vim-airline'              , {'branch': 'master' }
Plug 'vim-airline/vim-airline-themes'       , {'branch': 'master' }
" Tab Ccompletion collector; ddc and lsp
Plug 'vim-denops/denops.vim'                , {'branch': 'main'   }
Plug 'Shougo/ddc.vim'                       , {'branch': 'main'   }
Plug 'Shougo/ddc-around'                    , {'branch': 'main'   }
Plug 'Shougo/ddc-matcher_head'              , {'branch': 'main'   }
Plug 'Shougo/ddc-sorter_rank'               , {'branch': 'main'   }
Plug 'Shougo/ddc-omni'                      , {'branch': 'main'   }
Plug 'Shougo/pum.vim'                       , {'branch': 'main'   }
" LSP setup
Plug 'neovim/nvim-lspconfig'                , {'branch': 'master' }
Plug 'Shougo/ddc-nvim-lsp'                  , {'branch': 'main'   }
" Linting (code checking)
Plug 'jose-elias-alvarez/null-ls.nvim'      , {'branch': 'main'   }
"Plug 'dense-analysis/ale'                 , {'branch': 'master' }
"Plug 'statiolake/ddc-ale'                 , {'branch': 'master' }
" Snippets (code snippet inserter)
Plug 'SirVer/ultisnips'                     , {'branch': 'master' }
Plug 'honza/vim-snippets'                   , {'branch': 'master' }
Plug 'thomasfaingnaert/vim-lsp-ultisnips'   , {'branch': 'master' }
Plug 'thomasfaingnaert/vim-lsp-snippets'    , {'branch': 'master' }
" Function argument expander
Plug 'Shougo/echodoc.vim'                   , {'branch': 'master' }
" Grammar check
Plug 'rhysd/vim-grammarous'                 , {'branch': 'master' }
" Ctags as in code tags
Plug 'ludovicchabant/vim-gutentags'         , {'branch': 'master' }
" LaTeX editing
Plug 'lervag/vimtex'                        , {'branch': 'master' }
" Config file types
Plug 'aouelete/sway-vim-syntax'             , {'branch': 'master' }
Plug 'bbaserdem/musicbrainz-vim-syntax'     , {'branch': 'main'   }
Plug 'baskerville/vim-sxhkdrc'              , {'branch': 'master' }
Plug 'gentoo/gentoo-syntax'                 , {'branch': 'master' }
Plug 'brgmnn/vim-syncthing'                 , {'branch': 'master' }
Plug 'vim-scripts/MatlabFilesEdition'       , {'branch': 'master' }
call plug#end()

"------------"
"---CONFIG---"
"------------"

"---Base16---"
" Fix for ANSI terminal colorscheme; should work with most terminals
let base16colorspace=256

"---Nvim LSP---"
lua require('lspconfig').texlab.setup{}

"---Null-Ls---"
lua require('null-ls-config')

"---VimGrammarous---"
" Check only comments; except these file types
let g:grammarous#default_comments_only_filetypes = {
    \ '*' : 1,
    \ 'help' : 0,
    \ 'markdown' : 0,
    \ 'latex' : 0,
\ }
let g:grammarous#use_vim_spelllang = 1
let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#show_first_error = 1

"---echodoc.vim---"
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Identifier

"---indent_blankline---"
lua << EOF
    vim.opt.list = true
    vim.opt.listchars:append("eol:↴")

    require("indent_blankline").setup {
        show_end_of_line = true,
    }
EOF

"---FuzzyFinder---"
let g:fzf_command_prefix = 'Fzf'                " Prefix commands with Fzf

"---NERDTree---"
" Automatically launch NERDTree on start
"augroup nerdtreestart
"    autocmd!
"    autocmd vimenter * NERDTree | wincmd l
"augroup END
" Close if NERDTree is the last window
augroup nerdtreequit
    autocmd!
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

"---Gitgutter---"
let g:gitgutter_max_signs = 1000                " Maximum amount to show
set foldtext=gitgutter#fold#foldtext()          " Show changes in folded lines

"---Airline---"
"let g:airline_statusline_ontop = 1              " Put bar on top
let g:airline#extensions#ale#enabled = 1        " Enable lint extension
let g:airline#extensions#tabline#enabled = 1    " Enable tabline for buffers
let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#gutentags#enabled = 1  " Enable ctags extension
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

"---Vimtex---"
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_progname = 'nvr'          " For callback functionality
let g:tex_flavor = 'latex'                      " No plaintex
"let g:vimtex_complete_enabled = 1               " Enable omnifunc
" YaLafi
"let g:vimtex_grammar_vlty = {}
"let g:vimtex_grammar_vlty.lt_command = 'languagetool'
"let g:vimtex_grammar_vlty.server = 'my'
"let g:vimtex_grammar_vlty.show_suggestions = 1
"let g:vimtex_grammar_vlty.shell_options =
"        \   ' --multi-language'
"        \ . ' --packages "*"'
"        \ . ' --define ~/.config/vlty/defs.tex'
"        \ . ' --replace ~/.config/vlty/repls.txt'
"        \ . ' --equation-punctuation display'
"        \ . ' --single-letters "i.\,A.\|z.\,B.\|\|"'
" TeXtidote
"let g:vimtex_grammar_textidote = {
"    \ 'jar'     :   '/usr/share/java/texidote.jar',
"    \ 'args'    :   '--output plain',
"    \}

"---ddc---"
" Config is moved cause too much to abstract
source $XDG_CONFIG_HOME/nvim/ddc-config.vim
