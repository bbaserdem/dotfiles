-- Bootstrapping Packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end
vim.api.nvim_command("packadd packer.nvim")

-- Load packer
require('packer')

-- Reload packer each time this file is modified
vim.cmd([[
  augroup packerUserConfigReload
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Return the require for use in 'config' parameter of packer's use
function get_setup(name)
  return string.format('require("setup/%s")', name)
end

-- Packer installing plugins
return require('packer').startup(
  function(use)
    --[[-------------------------------------------------------------------]]--
    --[[--------------------Packer can manage itself-----------------------]]--
    --[[-------------------------------------------------------------------]]--
    use 'wbthomason/packer.nvim'

  --[[---------------------------------------------------------------------]]--
  --[[----------------------Plugins for utilities--------------------------]]--
  --[[---------------------------------------------------------------------]]--

  -- Don't close windows if deleting a buffer
  use 'famiu/bufdelete.nvim'

  -- Make directories while saving if they don't exist
  use 'jghauser/mkdir.nvim'

  -- Notifications on screen
  use 'rcarriga/nvim-notify'

  -- URL exposer and handler
  use { 'axieax/urlview.nvim',
    opt = true,
    requires = {
      'nvim-telescope/telescope.nvim',
      'stevearc/dressing.nvim',
    }
  }

  -- Session manager
  use 'rmagatti/auto-session'

  -- Mouse gesture plugin
  use 'notomo/gesture.nvim'

  -- Interacting with Vim marks
  use { 'chentau/marks.nvim', config = get_setup('marks') }

  -- Indent guiding lines
  use { 'lukas-reineke/indent-blankline.nvim', config = get_setup('indentblankline') }

  -- File explorer
  use { 'kyazdani42/nvim-tree.lua', config = get_setup('nvimtree'),
    requires = {
      'kyazdani42/nvim-web-devicons',
    }
  }

  -- Improve default vim.ui interfaces
  use 'stevearc/dressing.nvim'

  -- Scrollbar
  use { 'petertriho/nvim-scrollbar', config = get_setup('scrollbar') }

  -- Status bar
  use 'feline-nvim/feline.nvim'

  -- Git decorations and functions
  use 'lewis6991/gitsigns.nvim'

  -- Fuzzy search
  use { 'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }

  -- Spellchecker
  use 'lewis6991/spellsitter.nvim'

  -- UI component Library
  use 'Muniftanjim/nui.nvim'

  --[[---------------------------------------------------------------------]]--
  --[[-Plugins for language server protocol (LSP), parsing and diagnostics-]]--
  --[[---------------------------------------------------------------------]]--

  -- Collection of common configs
  use 'neovim/nvim-lspconfig'

  -- Install missing servers
  use 'williamboman/nvim-lsp-installer'

  -- Pictograms to LSP messages
  use 'onsails/lspkind.nvim'

  -- Adapt color schemes without LSP compatibility built in
  use 'folke/lsp-colors.nvim'

  -- Display menu for diagnostic messages
  use { 'folke/trouble.nvim', config = get_setup('trouble'),
    requires = 'kyazdani42/nvim-web-devicons',
  }

  -- Add static linters to interface like LSPs
  use { 'jose-elias-alvarez/null-ls.nvim', config = get_setup('null_ls'),
    requires = 'nvim-lua/plenary.nvim',
  }

  -- Parser tool integration with nvim
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  -- Code dimmer for ufocused parts
  use { 'folke/twilight.nvim',
    requires = 'nvim-treesitter/nvim-treesitter'
  }

  -- Function signatures from completions
  use 'Shougo/echodoc.vim'

  --[[---------------------------------------------------------------------]]--
  --[[---------------------Tab completion and Snippets---------------------]]--
  --[[---------------------------------------------------------------------]]--

  -- Snippets
  use { 'SirVer/ultisnips',
    requires = 'honza/vim-snippets'
  }

  --[[---------------------------------------------------------------------]]--
  --[[------------------------Tool Integration-----------------------------]]--
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
  --[[------------------------Language helpers-----------------------------]]--
  --[[---------------------------------------------------------------------]]--

  -- LaTeX
  -- Specific TeXlab config for LSP to enable backsearch
  use { 'f3fora/nvim-texlabconfig', config = get_setup('texlabconfig'),
    --ft = { 'tex', 'bib' },
    --cmd = { 'TexlabInverseSearch' },
  }
  -- Integration (only helps clean directory for now)
  use 'lervag/vimtex'

  -- Markdown
  -- Render MD file in buffer
  use 'ellisonleao/glow.nvim'
  -- Render MD file to html
  use { 'davidgranstrom/nvim-markdown-preview',
    cmd = { 'MarkdownPreview' },
  }
  -- Export documentation to vimdoc
  use 'kdheepak/panvimdoc'
  -- Follow MD links
  use { 'jakewvincent/mkdnflow.nvim', config = get_setup('mkdnflow'),
    disable = true,
  }

  -- Config file type highlighting
  use 'aouelete/sway-vim-syntax'
  use 'bbaserdem/musicbrainz-vim-syntax'
  use 'baskerville/vim-sxhkdrc'
  use 'gentoo/gentoo-syntax'
  use 'brgmnn/vim-syncthing'
  use 'vim-scripts/MatlabFilesEdition'

  --[[---------------------------------------------------------------------]]--
  --[[--------------------------Color Schemes------------------------------]]--
  --[[---------------------------------------------------------------------]]--
  --use { 'adisen99/apprentice.nvim', { requires = 'rktjmp/lush.nvim' } }
  use 'tjdevries/colorbuddy.nvim'
  -- High contrast
  use 'bluz71/vim-moonfly-colors'
  -- Nice themes
  use 'ChristianChiarulli/nvcode-color-schemes.vim'
  -- Faded themes
  use 'sainnhe/gruvbox-material'
  use 'savq/melange'
  use 'sainnhe/sonokai'
  use 'tomasiser/vim-code-dark'

  --[[---------------------------------------------------------------------]]--
  --[[--Automatically set up your configuration after cloning packer.nvim--]]--
  --[[-- Put this at the end after all plugins                           --]]--
  --[[---------------------------------------------------------------------]]--
  if packer_bootstrap then
    require('packer').sync()
  end
end
)
