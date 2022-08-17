--[[------------------------------------------------------------------------]]--
--[[-------------------------------PLUGIN CONFIG----------------------------]]--
--[[------------------------------------------------------------------------]]--
local fn = vim.fn
local g = vim.g
-- Export things here
M = {}

-- Bootstrapping Packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    M.PACKER_BOOTSTRAP = fn.system({
        'git',
        'clone',
        '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    print 'Bootstrapping packer, close and reopen Neovim ...'
    vim.api.nvim_command('packadd packer.nvim')
end
-- Reload us on save
vim.api.nvim_create_autocmd( { 'BufWritePost', }, {
    group = vim.api.nvim_create_augroup( 'PackerUserConfig', { clear = true, }),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerSync',
})

-- Plugin list
M.this_setup = require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }
     --[[--------------------------------------------------------------------]]--
     --[[------------------------Plugins for utilities-----------------------]]--
     --[[--------------------------------------------------------------------]]--
     -- Don't close windows if deleting a buffer
    use { 'famiu/bufdelete.nvim', disable = false,
    }-- Make directories while saving if they don't exist
    use { 'jghauser/mkdir.nvim', disable = false,
    }-- Notifications on screen
    use { 'rcarriga/nvim-notify', disable = false,
    }-- URL exposer and handler
    use { 'axieax/urlview.nvim', disable = false,
        requires = {
            'nvim-telescope/telescope.nvim',
            'stevearc/dressing.nvim',
        }
    }-- Session manager
    use { 'rmagatti/auto-session', disable = false,
        requires = {
            'nvim-telescope/telescope.nvim',
            'rmagatti/session-lens',
        },
        config = function()
            require('auto-session').setup({
                auto_session_enable_last_session = false,
                auto_restore_enabled = false,
                auto_session_use_git_branch = true,
            })
            require('session-lens').setup({
                path_display = { 'shorten', },
                previewer = true,
            })
        end,
    }
     -- Interacting with Vim marks
    use { 'chentoast/marks.nvim', disable = false,
        config = function()
            require('marks').setup({
                default_mappings = true,
            })
        end,
    }-- Indent guiding lines
    use { 'lukas-reineke/indent-blankline.nvim', disable = false,
        config = function()
            require('indent_blankline').setup({
                space_char_blankline = " ",
                colored_indent_levels = true,
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = false,
            })
        end,
    }-- File explorer
    use { 'kyazdani42/nvim-tree.lua', disable = false,
        requires = {
            'kyazdani42/nvim-web-devicons',
        }
    } -- Improve default vim.ui interfaces
    use { 'stevearc/dressing.nvim', disable = false, }
     -- Scrollbar
    use { 'petertriho/nvim-scrollbar', disable = false,
        config = function()
            require('scrollbar').setup({
                show = true,
            })
        end,
    }-- Status bar
    use { 'nvim-lualine/lualine.nvim', disable = false,
        requires = {
            { 'kyazdani42/nvim-web-devicons', opt = true, },
            { 'SmiteshP/nvim-gps', config = function()
                require('nvim-gps').setup({})
            end,},
            'doums/lsp_spinner.nvim',
        },
    }-- Git decorations and functions
    use { 'lewis6991/gitsigns.nvim', disable = false,
        config = function()
            require('gitsigns').setup({})
        end,
    }-- Fuzzy search
    use { 'nvim-telescope/telescope.nvim', disable = false,
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ui-select.nvim',
        },
    }-- File search
    use { 'nvim-telescope/telescope-fzf-native.nvim', disable = false,
        after = 'telescope.nvim',
        run = 'make',
    }-- Spellchecker
    use { 'lewis6991/spellsitter.nvim', disable = false,
    }-- Better tab window
    use { 'romgrk/barbar.nvim', disable = false,
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }-- Minimalism inducer
    use { 'Pocco81/TrueZen.nvim', disable = false,
    }-- Tmux integration
    use { 'aserowy/tmux.nvim', disable = false,
    }-- Navigate between neovim split and tmux panes
    use { 'numToStr/Navigator.nvim', disable = false,
    }-- Code commentor
    use { 'numToStr/Comment.nvim', disable = false,
        config = function()
            require('Comment').setup({
                padding = true,
                mappings = {
                    basic = false,
                    extra = false,
                    extended = false,
                },
            })
        end,
    }-- Key mappings
    use { 'folke/which-key.nvim', disable = false,
        config = function()
            require('which-key').setup({
                plugins = {
                    marks = true,
                    registers = true,
                    spelling = false,
                    presets = {
                        operators = true,
                        motions = true,
                        text_objects = true,
                        windows = true,
                        nav = true,
                        z = true,
                        g = true,
                    },
                },
            })
        end
    }-- Startup stuff
    use { 'startup-nvim/startup.nvim', disable = false,
        requires = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('startup').setup({
                theme = 'dashboard',
            })
        end,
    }-- Todo stuff
    use { 'nvim-neorg/neorg', disable = false,
    -- tag = "latest",
        ft = "norg",
        after = "nvim-treesitter", -- You may want to specify Telescope here as well
        config = function()
            require('neorg').setup({})
        end,
    }
    --[[--------------------------------------------------------------------]]--
    --[[-Plugins for language server protocol-LSP, parsing and diagnostics--]]--
    --[[--------------------------------------------------------------------]]--
    -- Collection of common configs
    use { 'neovim/nvim-lspconfig', disable = false,
        requires ={
            'folke/lsp-colors.nvim',    -- Adapt color schemes without LSP
            'kosayoda/nvim-lightbulb',-- Show available code actions
        }
    }-- Install missing servers
    use { 'williamboman/nvim-lsp-installer', disable = false,
    }-- Display menu for diagnostic messages
    use { 'folke/trouble.nvim', disable = false,
        requires = 'kyazdani42/nvim-web-devicons',
    }-- Add static linters to interface like LSPs
    use { 'jose-elias-alvarez/null-ls.nvim', disable = false,
        requires = 'nvim-lua/plenary.nvim',
    }-- Parser tool integration with nvim
    use { 'nvim-treesitter/nvim-treesitter', disable = false,
        requires = {
            'p00f/nvim-ts-rainbow',         -- Highlighter for parentheses
            'folke/twilight.nvim',            -- Dims unused code
        },
        run = ':TSUpdate',
    }
     -- Symbol menu for the current language
    use { 'simrat39/symbols-outline.nvim', disable = false,
    }

     --[[---------------------------------------------------------------------]]--
     --[[-----------------------Tab completion and Snippets-------------------]]--
     --[[---------------------------------------------------------------------]]--
     -- Nvim-cmp
    use { 'hrsh7th/nvim-cmp', disable = false,
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-document-symbol',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-omni',
            'saadparwaiz1/cmp_luasnip',
            'andersevenrud/cmp-tmux',
            'tamago324/cmp-zsh',
            'ray-x/cmp-treesitter',
            'onsails/lspkind.nvim'
        }
    }
     -- Snippets
    use { 'L3MON4D3/LuaSnip', disable = false,
        requires = 'rafamadriz/friendly-snippets',
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip').config.setup({
                ext_opts = {
                    [require('luasnip.util.types').choiceNode] = {
                        active = {
                            virt_text = { { '●', 'GruvboxOrange', }, }, },
                    },
                    [require('luasnip.util.types').insertNode] = {
                        active = {
                            virt_text = { { '●', 'GruvboxBlue', }, }, },
                    },
                },
            })
        end,
    }
     --[[---------------------------------------------------------------------]]--
     --[[--------------------------Language helpers---------------------------]]--
     --[[---------------------------------------------------------------------]]--

     -- LaTeX
     -- Build using vimtex
    use { 'lervag/vimtex', disable = false,
        ft = {'tex', 'bib'},
        cmd = { 'VimtexInverseSearch' },
    } -- Render equations to preview in ASCII
    use { 'jbyuki/nabla.nvim', disable = false,
        ft = {'tex', 'markdown'},
    }
     -- Markdown
     -- Render MD file in buffer
    use { 'ellisonleao/glow.nvim', disable = false, }
     -- Render MD file to html
    use { 'davidgranstrom/nvim-markdown-preview', disable = false,
        ft = {'tex', 'latex', 'plaintex', 'markdown', },
        cmd = { 'MarkdownPreview' },
    }-- Export documentation to vimdoc
    use { 'kdheepak/panvimdoc', disable = false,
        opt = true,
    } -- Follow MD links
    use { 'jakewvincent/mkdnflow.nvim', disable = false,
        ft = {'markdown', 'md', 'rmd'},
        config = function()
            require('mkdnflow').setup({
                create_dirs = true,
                filetypes = {
                    md = true,
                    rmd = true,
                    markdown = true,
                },
                wrap = true,
            })
        end,
    }-- File type highlighting
    use { 'aouelete/sway-vim-syntax', disable = false, }
    use { 'bbaserdem/musicbrainz-vim-syntax', disable = false, }
    use { 'baskerville/vim-sxhkdrc', disable = false, }
    use { 'gentoo/gentoo-syntax', disable = false, }
    use { 'brgmnn/vim-syncthing', disable = false, }
    use { 'vim-scripts/MatlabFilesEdition', disable = false, }
    use { 'elkowar/yuck.vim', disable = false, }

     --[[---------------------------------------------------------------------]]--
     --[[----------------------------Color Schemes----------------------------]]--
     --[[---------------------------------------------------------------------]]--
     -- High contrast
    use { 'bluz71/vim-moonfly-colors', disable = false,
    }-- Nice themes
    use { 'catppuccin/nvim', disable = false,
        as = 'catppuccin',
    }-- One dark
    use { 'navarasu/onedark.nvim', disable = false,
    }-- Melange; browner black
    use { 'savq/melange', disable = false,
    }-- Vim code dark; true black background
    use { 'tomasiser/vim-code-dark', disable = false,
    }
     --[[---------------------------------------------------------------------]]--
     --[[---Automatically set up your configuration after cloning packer.nvim-]]--
     --[[-- Put this at the end after all plugins                                                         ]]--
     --[[---------------------------------------------------------------------]]--
    if M.PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

--[[-----------------------------------------------------------------------]]--
--[[------------------------------- CONFIGS -------------------------------]]--
--[[-----------------------------------------------------------------------]]--
-- Plugin loader
local plugLoader = function(name, opts)
	local this_plug_ok, this_plug = pcall(require, name)
    if this_plug_ok then
        this_plug.setup(opts)
    else
        print('Could not configure ' .. name .. '" \n' .. this_plug .. '\n')
    end
end
M.loader = plugLoader

-- Barbar: Better tab bar
vim.g.bufferline = {
    animation = true,               -- Enable/disable animations
    auto_hide = false,              -- Enable/disable auto-hide
    tabpages = true,                -- Enable/disable current/total pages (top R)
    closable = true,                -- Enable/disable close button
    clickable = true,               -- Enables/disable clickable tabs (mid deletes)
    exclude_ft = {'javascript'},    -- Excludes buffers from the tabline
    exclude_name = {'package.json'},
    icons = 'both',                 -- Enable/disable icons
    icon_custom_colors = false,
    -- Configure icons on the bufferline.
    icon_separator_active = '▎',
    icon_separator_inactive = '▎',
    icon_close_tab = '',
    icon_close_tab_modified = '●',
    icon_pinned = '車',
    insert_at_end = false,          -- Default is to insert after current buffer.
    insert_at_start = false,
    maximum_padding = 1,            -- Sets the maximum padding
    maximum_length = 30,            -- Sets the maximum buffer name length.
    semantic_letters = true,
    letters = 'aoeuidhtnsAOEUIDHTNSqjkxbmwvQJKXBMWVpyfgPYFGcrlCRL',
    no_name_title = nil,
}

-- Markdown preview
vim.g.nvim_markdown_preview_theme = 'solarized-dark'
vim.g.nvim_markdown_preview_format = 'gfm'

-- Nvim Tree
plugLoader('nvim-tree', {
    open_on_tab = true,
    update_cwd = true,
    actions = {
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    view = {
        width = 20,
        side = 'left',
        preserve_window_proportions = false,
        number = false,
        signcolumn = 'yes',
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    filters = {
        dotfiles = false,
        custom = { -- Ignore aux latex files
            [[\.aux$]],
            [[\.bbl$]],
            [[\.bcf$]],
            [[\.blg$]],
            [[\.fdb_latexmk$]],
            [[\.fls$]],
            [[\.lof$]],
            [[\.log$]],
            [[\.out$]],
            [[\.run\.xml$]],
            [[\.synctex\.gz$]],
            [[\.toc$]],
            },
        exclude = {},
    },
})

-- TreeSitter
plugLoader('nvim-treesitter.configs', {
    -- A list of parser names, or "all"
    ensure_installed = {
        'bash',
        'bibtex',
        'c',
        'cmake',
        'cpp',
        'devicetree',
        'dockerfile',
        'fennel',
        'go',
        'help',
        'html',
        'http',
        'java',
        'javascript',
        'json',
        'lua',
        'latex',
        --'markdown',
        'python',
        'r',
        'regex',
        'rust',
        'todotxt',
        'vim',
        'yaml',
        'norg',
    },
    sync_install = false,       -- Install parsers synchronously
    ignore_install = {          -- List of parsers to ignore installing (for "all")
        'javascript',
    },
    highlight = {               -- `false` will disable the whole extension
        enable = true,
        disable = {
            'rust',
            'latex',
        },
        additional_vim_regex_highlighting = false,
    },
    rainbow = {                             -- Rainbow paranthesing
        enable = true,                    -- Also highlight non-bracket delimiters
        extended_mode = true,     -- like html tags, boolean or table: lang->boolean
        max_file_lines = nil,     -- Do not enable for files with more than n lines
    },
    indent = {
        enable = true,
    },
})

-- Twilight
plugLoader('twilight', {
    dimming = {
        alpha = 0.25,                     -- amount of dimming
        color = {                             -- we try to get the foreground from the highlight
            'Normal',                         --groups or fallback color
            '#ffffff',
        },                                            -- when true, other windows will be fully dimmed
        inactive = true,                --(unless they contain the same buffer)
    },
    context = 7,                            -- amount of lines we will try to show
    treesitter = true,                -- use treesitter when available for the filetype
    expand = {                                -- treesitter is used to automatically expand the
        'function',                         --visible text, but you can further control the
        'method',                             --types of nodes that will always be fully expanded
        'table',                                -- for treesitter, we we always try to expand to the
        'if_statement',                 --top-most ancestor with these types
    },
    exclude = {}, -- exclude these filetypes
})

-- Trouble
plugLoader('trouble', {
    position = 'top',
    height = 10,
    icons = true,
    mode = "workspace_diagnostics",
    fold_open = "",
    fold_closed = "",
    group = true,
    padding = true,
    action_keys = {
        close = "q",
        cancel = "<esc>",
        refresh = "r",
        jump = {"<cr>", "<tab>"},
        open_split = { ',' },
        open_vsplit = { '.' },
        open_tab = { 'N' },
        jump_close = {"O"},
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "I",
        preview = "p",
        close_folds = {"zM", "zm"},
        open_folds = {"zR", "zr"},
        toggle_fold = {"zA", "za"},
        previous = "k",
        next = "j"
    },
    indent_lines = true,
    auto_open = false,
    auto_close = false,
    auto_preview = false,
    auto_fold = true,
    auto_jump = {"lsp_definitions"},
    use_diagnostic_signs = true,
})

-- Vimtex
g.vimtex_mappings_enabled = 0
g.vimtex_compiler_method = 'latexmk'
--[[
g.vimtex_compiler_tectonic = {
    options = {
        '--synctex',
    },
}
--]]
g.vimtex_view_method = 'zathura'
g.vimtex_compiler_progname = 'nvr'
--g.vimtex_view_zathura_options = 


--[[-----------------------------------------------------------------------]]--
--[[--------------------------- EXTERNAL FILES ----------------------------]]--
--[[-----------------------------------------------------------------------]]--

-- External file loader
local plugExtLoad = function(name)
    local this_plug_ok, this_plug = pcall(require, 'plugin-configs.' .. name)
    if not this_plug_ok then
        error('Could not load external config ' .. name .. '" \n' .. this_plug .. '\n')
    end
end
M.external = plugExtLoad

-- Loadable config files
local config_modules = {
    'cmp',
    'null-ls',
    'lualine',
}
for _, module in ipairs(config_modules) do
    plugExtLoad(module)
end

return M
