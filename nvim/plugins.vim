"-----------------"
"-----PLUGINS-----"
"-----------------"
scriptencoding utf-8

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
Plug 'MunifTanjim/nui.nvim'                 , {'branch': 'main'   }
Plug 'tpope/vim-fugitive'                   , {'branch': 'master' }
" Resources; for other plugins
Plug 'kyazdani42/nvim-web-devicons'         , {'branch': 'master' }
" Utility
Plug 'famiu/bufdelete.nvim'                 , {'branch': 'master' }
Plug 'jghauser/mkdir.nvim'                  , {'branch': 'main'   }
Plug 'rcarriga/nvim-notify'                 , {'branch': 'master' }
Plug 'stevearc/dressing.nvim'               , {'branch': 'master' }
Plug 'axieax/urlview.nvim'                  , {'branch': 'main'   }
Plug 'petertriho/nvim-scrollbar'            , {'branch': 'main'   }
Plug 'rmagatti/auto-session'                , {'branch': 'main'   }
Plug 'notomo/gesture.nvim'                  , {'branch': 'master' }
" Tmux
Plug 'aserowy/tmux.nvim'                    , {'branch': 'main'   }
Plug 'danielpieper/telescope-tmuxinator.nvim',{'branch':'main'   }
Plug 'numToStr/Navigator.nvim'              , {'branch': 'master' }
" Marks
Plug 'chentau/marks.nvim'                   , {'branch': 'master' }
" Indentation tracker
Plug 'lukas-reineke/indent-blankline.nvim'  , {'branch': 'master' }
" Fuzzyfinder
Plug 'nvim-telescope/telescope.nvim'        , {'branch': 'master' }
Plug 'nvim-telescope/telescope-fzf-native.nvim',{'branch': 'main', 'do': 'make'}
Plug 'nvim-telescope/telescope-ui-select.nvim',{'branch': 'master'}
" File browser(s)
Plug 'kyazdani42/nvim-tree.lua'             , {'branch': 'master' }
Plug 'preservim/nerdtree'                   , {'branch': 'master' }
Plug 'Xuyuanp/nerdtree-git-plugin'          , {'branch': 'master' }
" Git management
Plug 'airblade/vim-gitgutter'               , {'branch': 'master' }
" Status bar
Plug 'vim-airline/vim-airline'              , {'branch': 'master' }
Plug 'vim-airline/vim-airline-themes'       , {'branch': 'master' }
" Tab completion
Plug 'vim-denops/denops.vim'                , {'branch': 'main'   }
Plug 'Shougo/ddc.vim'                       , {'branch': 'main'   }
Plug 'Shougo/ddc-around'                    , {'branch': 'main'   }
Plug 'Shougo/ddc-matcher_head'              , {'branch': 'main'   }
Plug 'Shougo/ddc-sorter_rank'               , {'branch': 'main'   }
Plug 'Shougo/ddc-omni'                      , {'branch': 'main'   }
Plug 'Shougo/ddc-nvim-lsp'                  , {'branch': 'main'   }
Plug 'Shougo/pum.vim'                       , {'branch': 'main'   }
" Parsing stuff using treesitter
Plug 'nvim-treesitter/nvim-treesitter'      , {'branch': 'master', 'do': ':TSUpdate'}
Plug 'delphinus/ddc-treesitter'             , {'branch': 'main'   }
Plug 'lewis6991/spellsitter.nvim'           , {'branch': 'master' }
Plug 'folke/twilight.nvim'                  , {'branch': 'main'   }
" LSP setup
Plug 'neovim/nvim-lspconfig'                , {'branch': 'master' }
Plug 'onsails/lspkind.nvim'                 , {'branch': 'master' }
" Linting (code checking)
Plug 'jose-elias-alvarez/null-ls.nvim'      , {'branch': 'main'   }
"Plug 'dense-analysis/ale'                 , {'branch': 'master' }
"Plug 'statiolake/ddc-ale'                 , {'branch': 'master' }
" Snippets (code snippet inserter)
Plug 'SirVer/ultisnips'                     , {'branch': 'master' }
Plug 'honza/vim-snippets'                   , {'branch': 'master' }
Plug 'matsui54/ddc-ultisnips'               , {'branch': 'main'   }
" Function argument expander
Plug 'Shougo/echodoc.vim'                   , {'branch': 'master' }
" Grammar check
Plug 'rhysd/vim-grammarous'                 , {'branch': 'master' }
" Ctags as in code tags
Plug 'ludovicchabant/vim-gutentags'         , {'branch': 'master' }
" LaTeX editing
Plug 'lervag/vimtex'                        , {'branch': 'master' }
" Markdown editing
Plug 'ellisonleao/glow.nvim'                , {'branch': 'main'   }
Plug 'davidgranstrom/nvim-markdown-preview' , {'branch': 'master' }
Plug 'kdheepak/panvimdoc'                   , {'branch': 'main'   }
Plug 'jakewvincent/mkdnflow.nvim'           , {'branch': 'main'   }
" Config file types
Plug 'aouelete/sway-vim-syntax'             , {'branch': 'master' }
Plug 'bbaserdem/musicbrainz-vim-syntax'     , {'branch': 'main'   }
Plug 'baskerville/vim-sxhkdrc'              , {'branch': 'master' }
Plug 'gentoo/gentoo-syntax'                 , {'branch': 'master' }
Plug 'brgmnn/vim-syncthing'                 , {'branch': 'master' }
Plug 'vim-scripts/MatlabFilesEdition'       , {'branch': 'master' }
" Colorscheme
Plug 'adisen99/apprentice.nvim'             , {'branch': 'main'   }
Plug 'sainnhe/edge'                         , {'branch': 'master' }
Plug 'Everblush/everblush.vim'              , {'branch': 'main'   }
Plug 'sainnhe/gruvbox-material'             , {'branch': 'master' }
Plug 'marko-cerovac/material.nvim'          , {'branch': 'main'   }
Plug 'savq/melange'                         , {'branch': 'master' }
Plug 'rafamadriz/neon'                      , {'branch': 'main'   }
Plug 'mhartington/oceanic-next'             , {'branch': 'master' }
Plug 'navarasu/onedark.nvim'                , {'branch': 'master' }
Plug 'kvrohit/rasmus.nvim'                  , {'branch': 'main'   }
Plug 'sainnhe/sonokai'                      , {'branch': 'master' }
Plug 'Th3Whit3Wolf/space-nvim'              , {'branch': 'main'   }
Plug 'tomasiser/vim-code-dark'              , {'branch': 'master' }
Plug 'bluz71/vim-moonfly-colors'            , {'branch': 'master' }
Plug 'Mofiqul/vscode.nvim'                  , {'branch': 'main'   }
Plug 'glepnir/zephyr-nvim'                  , {'branch': 'main'   }
Plug 'ChristianChiarulli/nvcode-color-schemes.vim',{'branch':'master'}
call plug#end()

"------------"
"---CONFIG---"
"------------"

"---VS Code---"
let g:vscode_style = 'dark'
let g:vscode_transparency = 1
let g:vscode_italic_comment = 1
let g:vscode_disable_nvimtree_bg = v:true

"---Nvim-Scrollbar---"
lua << EOF
require("scrollbar").setup({
    show = true,
})
EOF

"---Nvim-tree.lua---"
lua << EOF
require'nvim-tree'.setup { -- BEGIN_DEFAULT_OPTS
    auto_reload_on_write = true,
    disable_netrw = false,
    hide_root_folder = false,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = true,
    open_on_setup_file = false,
    open_on_tab = true,
    sort_by = "name",
    update_cwd = false,
    view = {
        width = 30,
        height = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
            custom_only = false,
            list = {
                -- user mappings go here
            },
        },
    },
    renderer = {
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
        },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
    },
    ignore_ft_on_setup = {},
    system_open = {
        cmd = nil,
        args = {},
    },
    diagnostics = {
        enable = false,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 400,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = false,
        },
        open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            diagnostics = false,
            git = false,
            profile = false,
        },
    },
}
EOF
augroup NvimTreeClose
    autocmd!
    autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
augroup END


"---Nvim LSP---"
lua require('lspconfig').texlab.setup{}

"---Null-Ls---"
lua require('null-ls-config')

"---Lspkind.nvim---"
lua << EOF
require('lspkind').init({
    mode = 'symbol_text',
    preset = 'codicons',
})
EOF

"---Markdown Preview---"
let g:nvim_markdown_preview_theme = 'solarized-dark'
let g:nvim_markdown_preview_format = 'gfm'

"---Mkdnflow.nvim---"
lua << EOF
require('mkdnflow').setup({
    create_dirs = false,
    links_relative_to = 'current',
    wrap_to_beginning = true,
    wrap_to_end = true,
})
EOF
augroup MkdnflowWriteMarkdown
    autocmd!
    autocmd FileType markdown set autowriteall
augroup end

"---Marks.nvim---"
lua << EOF
require('marks').setup({
    default_mappings = true,
})
EOF

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
    --vim.opt.listchars:append("eol:↴")

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
