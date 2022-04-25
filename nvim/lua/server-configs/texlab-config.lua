--[[------------------------------------------------------------------------]]--
--[[------------------------- TeXlab  Setup --------------------------------]]--
--[[.For LaTeX, use texlab for code helping and compiling...................]]--
--[[------------------------------------------------------------------------]]--

-- File types to use this server with
local file_types = {
  'tex',
  'bib',
  'plaintex',
  'latex',
}
-- Configuration for pdf viewers for texlabconfig
local zathura_conf = {
  executable = 'zathura',
  args = {
    '--synctex-editor-command',
    'nvim --headless -c "TexlabInverseSearch \'%{input}\' %{line}"',
    '--synctex-forward',
    '%l:1:%f',
    '%p',
  },
}
-- Set inverse search
local texlabconfig = require('texlabconfig')
texlabconfig.setup({
  cache_activate = true,
  cache_filetypes = file_types,
  cache_root = vim.fn.stdpath('cache'),
  reverse_search_edit_cmd = 'edit',
  file_permission_mode = 438,
})

-- Send these options
Opts = {
  cmd = { 'texlab' },
  filetypes = file_types,
  settings = {
    texlab = {
      auxDirectory = '.',
      bibtexFormatter = 'texlab',
      build = {
        args = {'-pdf', '-interaction=nonstopmode', '-synctex=1', '%f', },
        executable = 'latexmk',
        forwardSearchAfter = true,
        onSave = false,
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = zathura_conf,
      latexFormatter = "latexindent",
      latexindent = {modifyLineBreaks =  true, },
    },
  },
}
return Opts
