--------------------------
--- LaTeX file configs ---
--------------------------
local wk = require('which-key')
wk.register({
  [ '<F5>'] = { ':TexlabBuild<CR>',   'Build project file'  , silent = false },
  ['<F17>'] = { ':TexlabForward<CR>', 'Forward search'      , silent = false },
  ['<F29>'] = { ':VimtexClean<CR>',   'Clean build'         , silent = false },
})
