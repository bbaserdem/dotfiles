--[[------------------------------------------------------------------------]]--
--[[------------------------- TeXlab  Setup --------------------------------]]--
--[[.For LaTeX, use texlab for code helping and compiling...................]]--
--[[------------------------------------------------------------------------]]--
local file_types = {
  'tex',
  'bib',
  'plaintex',
  'latex',
}


return function(opts)
  -- Create scaffold
  if not opts.settings then
    opts.settings = {}
  end
  if not opts.settings.texlab then
    opts.settings.texlab = {}
  end
  if not opts.settings.texlab.build then
    opts.settings.texlab.build = {}
  end
  -- Overwrite options
  opts.filetypes = file_types
  opts.settings.texlab.build.forwardSearchAfter = true
  opts.settings.texlab.onSave = true
  opts.settings.texlab.chktex = {
    onEdit = true,
    onOpenAndSave = true,
  }
  -- Use this plugin to enable backsearch along with forward search
  require('texlabconfig').setup({
    cache_activate = true,
    cache_filetypes = file_types,
    cache_root = vim.fn.stdpath('cache'),
    reverse_search_edit_cmd = 'tabedit',
    file_permission_mode = 438,
  })
  -- Set forward search
  opts.settings.texlab.forwardSearch = {
    executable = 'zathura',
    args = {
      '--synctex-editor-command',
      [[nvim --headless -c "TexlabInverseSearch '%{input}' %{line}"]],
      '--synctex-forward',
      '%l:1:%f',
      '%p',
    },
  }
  opts.settings.texlab.latexindent = {
    modifyLineBreaks = true,
  }
end
