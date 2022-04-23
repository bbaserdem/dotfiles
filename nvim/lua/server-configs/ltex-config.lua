--[[------------------------------------------------------------------------]]--
--[[---------------------------LTeX  Setup----------------------------------]]--
--[[.For LaTeX and markdown, use LTeX for grammar checking..................]]--
--[[------------------------------------------------------------------------]]--

return function(opts)
  opts.filetypes = {
    'tex',
    'bib',
    'plaintex',
    'latex',
    'gitcommit',
    'markdown',
    'org',
    'rst',
    'rnoweb',
  }
end
