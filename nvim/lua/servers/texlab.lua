--[[------------------------------------------------------------------------]]--
--[[------------------------- TeXlab  Setup --------------------------------]]--
--[[.For LaTeX, use texlab for code helping and compiling...................]]--
--[[------------------------------------------------------------------------]]--
local lspconfig = require('lspconfig')
local common_config = require('core/servers')

-- Use this plugin to enable backsearch along with forward search
require('texlabconfig').setup({
  config = {
    cache_activate = true,
    cache_filetypes = { 'tex', 'bib' },
    cache_root = vim.fn.stdpath('cache'),
    reverse_search_edit_cmd = 'edit',
    file_permission_mode = 438,
  },
})

lspconfig.texlab.setup{
  cmd = { "texlab" },
  on_attach = common_config.common_on_attach,
  --capabilities = common_config.capabilities,
  filetypes = { 'tex', 'bib', 'plaintex', 'latex' },
	rootPatterns = { ".git" },
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        forwardSearchAfter = true,
        onSave = false,
      },
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        executable = "zathura",
        args = {
          '--synctex-editor-command',
          [[nvim --headless -c "TexlabInverseSearch '%{input}' %{line}"]],
          '--synctex-forward',
          '%l:1:%f',
          '%p',
        },
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = true,
      },
    },
  },
}
