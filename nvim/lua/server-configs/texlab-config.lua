--[[------------------------------------------------------------------------]]--
--[[------------------------- TeXlab  Setup --------------------------------]]--
--[[.For LaTeX, use texlab for code helping and compiling...................]]--
--[[------------------------------------------------------------------------]]--

-- Use this plugin to enable backsearch along with forward search
local texlab_conf_ok, texlab_conf = pcall(require, 'texlabconfig')
if texlab_conf_ok then
  texlab_conf.setup()
end
local forward_search_settings = {
  executable = 'zathura',
  args = {
    '--synctex-editor-command',
    [[nvim --headless -c "TexlabInverseSearch '%{input}' %{line}"]],
    '--synctex-forward',
    '%l:1:%f',
    '%p',
  },
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
  opts.filetypes = { 'tex', 'bib', 'plaintex', 'latex' }
  opts.settings.texlab.build.forwardSearchAfter = true
  opts.settings.texlab.onSave = true
  opts.settings.texlab.chktex = {
    onEdit = true,
    onOpenAndSave = true,
  }
  opts.settings.texlab.forwardSearch = forward_search_settings
  opts.settings.texlab.latexindent = {
    modifyLineBreaks = true,
  }
end
