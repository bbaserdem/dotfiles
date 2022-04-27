--------------------------------
--- Treesitter configuration ---
--------------------------------
-- Treesitter main config
local treesitter_conf = require('nvim-treesitter.configs')
treesitter_conf.setup({
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
    'latex',
    'lua',
    --'markdown',
    'python',
    'r',
    'regex',
    'rust',
    'todotxt',
    'vim',
    'yaml',
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing (for "all")
  ignore_install = {
    'javascript'
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    disable = {
      'rust',
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- Rainbow panathesing
  rainbow = {
    enable = true,
    -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    extended_mode = true,
    -- Do not enable for files with more than n lines, int
    max_file_lines = nil,
  },
})
-- Twiligt config: inactive code dimmer
local twilight = require('twilight')
twilight.setup({
  dimming = {
    -- amount of dimming
    alpha = 0.25,
    -- we try to get the foreground from the highlight groups or fallback color
    color = { 'Normal', '#ffffff', },
    -- when true, other windows will be fully dimmed (unless they contain the same buffer)
    inactive = true,
  },
  -- amount of lines we will try to show around the current line
  context = 7,
  -- use treesitter when available for the filetype
  treesitter = true,
  -- treesitter is used to automatically expand the visible text,
  -- but you can further control the types of nodes that should always be fully expanded
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    'function',
    'method',
    'table',
    'if_statement',
  },
  exclude = {}, -- exclude these filetypes
})
