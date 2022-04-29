------------------------
--- Catppuccin Theme ---
------------------------
local config = {
  transparent_background = false,
  term_colors = false,
  styles = {
    comments = 'strikethrough',
    functions = 'bold',
    keywords = 'standout',
    strings = 'NONE',
    variables = 'italic',
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = 'standout',
        hints = 'NONE',
        warnings = 'italic',
        information = 'NONE',
      },
      underlines = {
        errors = 'undercurl',
        hints = 'underdot',
        warnings = 'underline',
        information = 'underdash',
      },
    },
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = true,
    },
    neotree = {
      enabled = false,
      show_root = false,
      transparent_panel = false,
    },
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = true,
    barbar = true,
    markdown = true,
    ts_rainbow = true,
    notify = true,
    symbols_outline = true,
  }
}
require('catppuccin').setup(config)
