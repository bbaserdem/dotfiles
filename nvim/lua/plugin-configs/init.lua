--[[------------------------------------------------------------------------]]--
--[[-------------------------------PLUGIN CONFIG----------------------------]]--
--[[------------------------------------------------------------------------]]--
local fn = vim.fn

-- Bootstrapping Packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print 'Bootstrapping packer, close and reopen Neovim ...'
  vim.api.nvim_command('packadd packer.nvim')
end

-- Installed plugins
local packer_end = require('packer').startup(function(use)
   --[[---------------------------------------------------------------------]]--
   --[[----------------------Packer can manage itself-----------------------]]--
   --[[---------------------------------------------------------------------]]--
  use { 'wbthomason/packer.nvim',
  }

   --[[---------------------------------------------------------------------]]--
   --[[------------------------Plugins for utilities------------------------]]--
   --[[---------------------------------------------------------------------]]--

   -- Don't close windows if deleting a buffer
  use { 'famiu/bufdelete.nvim',
    disable = false,
  }

   -- Make directories while saving if they don't exist
  use { 'jghauser/mkdir.nvim',
    disable = false,
  }

   -- Notifications on screen
  use { 'rcarriga/nvim-notify',
    disable = false,
  }

   -- URL exposer and handler
  use { 'axieax/urlview.nvim',
    disable = false,
    opt = true,
    requires = {
      'nvim-telescope/telescope.nvim',
      'stevearc/dressing.nvim',
    }
  }

   -- Session manager
  use { 'rmagatti/auto-session',
    disable = false,
  }

   -- Mouse gesture plugin
  use { 'notomo/gesture.nvim',
    disable = false,
  }

   -- Interacting with Vim marks
  use { 'chentau/marks.nvim',
    disable = false,
  }

   -- Indent guiding lines
  use { 'lukas-reineke/indent-blankline.nvim',
    disable = false,
  }

   -- File explorer
  use { 'kyazdani42/nvim-tree.lua',
    disable = false,
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }

   -- Improve default vim.ui interfaces
  use { 'stevearc/dressing.nvim',
    disable = false,
  }

   -- Scrollbar
  use { 'petertriho/nvim-scrollbar',
    disable = false,
  }

   -- Status bar
  use { 'nvim-lualine/lualine.nvim',
    disable = false,
    requires = {
      { 'kyazdani42/nvim-web-devicons', opt = true, },
      'SmiteshP/nvim-gps',
      'doums/lsp_spinner.nvim',
    },
  }

   -- Git decorations and functions
  use { 'lewis6991/gitsigns.nvim',
    disable = false,
  }

   -- Fuzzy search
  use { 'nvim-telescope/telescope.nvim',
    disable = false,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    disable = false,
    run = 'make',
  }

   -- Spellchecker
  use { 'lewis6991/spellsitter.nvim',
    disable = false,
  }

   -- UI component Library
  use { 'Muniftanjim/nui.nvim',
    disable = false,
  }

  -- Better tab window
  use { 'romgrk/barbar.nvim',
    disable = false,
    requires = { 'kyazdani42/nvim-web-devicons', },
  }

  -- Minimalism inducer
  use { 'Pocco81/TrueZen.nvim',
    disable = false,
  }

   --[[---------------------------------------------------------------------]]--
   --[[--Plugins for language server protocol (LSP), parsing and diagnostics]]--
   --[[---------------------------------------------------------------------]]--

   -- Collection of common configs
  use { 'neovim/nvim-lspconfig',
    disable = false,
  }

   -- Install missing servers
  use { 'williamboman/nvim-lsp-installer', 
    disable = false,
    requires = 'neovim/nvim-lspconfig',
  }

   -- Adapt color schemes without LSP compatibility built in
  use { 'folke/lsp-colors.nvim',
    disable = false,
  }

   -- Display menu for diagnostic messages
  use { 'folke/trouble.nvim',
    disable = false,
    requires = 'kyazdani42/nvim-web-devicons',
  }

   -- Add static linters to interface like LSPs
  use { 'jose-elias-alvarez/null-ls.nvim',
    disable = false,
    requires = 'nvim-lua/plenary.nvim',
  }

   -- Parser tool integration with nvim
  use { 'nvim-treesitter/nvim-treesitter',
    disable = false,
    requires = {
      'p00f/nvim-ts-rainbow',     -- Highlighter for parentheses
      'folke/twilight.nvim',      -- Dims unused code
    },
    run = ':TSUpdate',
  }

   -- Symbol menu for the current language
  use { 'simrat39/symbols-outline.nvim',
    disable = false,
  }

  -- LSP Status for debugging and following lua server
  use { 'j-hui/fidget.nvim',
  }

   --[[---------------------------------------------------------------------]]--
   --[[-----------------------Tab completion and Snippets-------------------]]--
   --[[---------------------------------------------------------------------]]--

   -- Snippets
  use { 'SirVer/ultisnips',
    disable = false,
    requires = 'honza/vim-snippets'
  }

   -- Nvim-cmp
  use { 'hrsh7th/nvim-cmp',
    disable = false,
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-omni',
      'SirVer/ultisnips',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'andersevenrud/cmp-tmux',
      'tamago324/cmp-zsh',
      'ray-x/cmp-treesitter',
      'onsails/lspkind.nvim'
    }
  }

   --[[---------------------------------------------------------------------]]--
   --[[--------------------------Tool Integration---------------------------]]--
   --[[---------------------------------------------------------------------]]--

   -- Tmux integration
  use { 'aserowy/tmux.nvim',
    opt = true,
  }

   -- Navigate between neovim split and tmux panes
  use { 'numToStr/Navigator.nvim',
    opt = true,
  }

   --[[---------------------------------------------------------------------]]--
   --[[--------------------------Language helpers---------------------------]]--
   --[[---------------------------------------------------------------------]]--

   -- LaTeX
   -- Specific TeXlab config for LSP to enable backsearch
  use { 'f3fora/nvim-texlabconfig',
    disable = false,
  }

   -- Markdown
   -- Render MD file in buffer
  use { 'ellisonleao/glow.nvim',
    disable = false,
  }
   -- Render MD file to html
  use { 'davidgranstrom/nvim-markdown-preview',
    disable = false,
    cmd = { 'MarkdownPreview' },
  }
   -- Export documentation to vimdoc
  use { 'kdheepak/panvimdoc',
    disable = false,
  }
   -- Follow MD links
  use { 'jakewvincent/mkdnflow.nvim',
    disable = false,
  }

   -- Config file type highlighting
  use { 'aouelete/sway-vim-syntax',
    disable = false,
  }
  use { 'bbaserdem/musicbrainz-vim-syntax',
    disable = false,
  }
  use { 'baskerville/vim-sxhkdrc',
    disable = false,
  }
  use { 'gentoo/gentoo-syntax',
    disable = false,
  }
  use { 'brgmnn/vim-syncthing',
    disable = false,
  }
  use { 'vim-scripts/MatlabFilesEdition',
    disable = false,
  }

   --[[---------------------------------------------------------------------]]--
   --[[----------------------------Color Schemes----------------------------]]--
   --[[---------------------------------------------------------------------]]--
   --use { 'adisen99/apprentice.nvim', { requires = 'rktjmp/lush.nvim' } }
   -- High contrast
  use { 'bluz71/vim-moonfly-colors',
    disable = false,
  }
   -- Nice themes
  use { 'ChristianChiarulli/nvcode-color-schemes.vim',
    disable = false,
  }
  use { 'catppuccin/nvim',
    disable = false,
    as = 'catppuccin',
  }
   -- Faded themes
  use { 'sainnhe/gruvbox-material',
    disable = false,
  }
  use { 'savq/melange',
    disable = false,
  }
  use { 'tomasiser/vim-code-dark',
    disable = false,
  }

   --[[---------------------------------------------------------------------]]--
   --[[---Automatically set up your configuration after cloning packer.nvim-]]--
   --[[-- Put this at the end after all plugins                             ]]--
   --[[---------------------------------------------------------------------]]--
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

--[[------------------]]--
--[[------CONFIGS-----]]--
--[[------------------]]--

-- Autoload function
local load_config_function = function(name)
	local plug_ok, plug = pcall(require, 'plugin-configs/' .. name .. '-config')
	if not plug_ok then
		error('Could not load ' .. name .. '" \n' .. plug .. '\n')
	end
end

-- Loadable config files
config_modules = {
	'catppuccin',
	'cmp_nvim_ultisnips',
	'lspkind',
	'cmp',
	'null-ls',
	'nvim-markdown-preview',
	'nvim-treesitter',
	'nvim-tree',
	'scrollbar',
	'trouble',
	'texlabconfig',
	--'mkdnflow'
	--'which-key',
	--'indent_blankline',
	'lualine',
  'barbar',
}

for _, module in ipairs(config_modules) do
	load_config_function(module)
end

return packer_end
