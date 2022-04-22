--[[------------------------------------------------------------------------]]--
--[[---------------------------LTeX  Setup----------------------------------]]--
--[[.For LaTeX and markdown, use LTeX for grammar checking..................]]--
--[[------------------------------------------------------------------------]]--
local lspconfig = require('lspconfig')
local common_config = require('core/servers')

lspconfig.ltex.setup({
  cmd = { "ltex-ls" },
  on_attach = common_config.on_attach,
  --capabilities = common_config.capabilities,
  filetypes = { 'tex', 'bib', 'plaintex', 'latex',
    'gitcommit', 'markdown', 'org', 'rst', 'rnoweb',
  },
  -- root_dir = "",
  -- get_language_id = "",
  single_file_support = true,
})
