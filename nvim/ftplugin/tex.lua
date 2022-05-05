--------------------------
--- LaTeX file configs ---
--------------------------
local wk = require('which-key')
wk.register({
  [ '<F5>'] = { ':TexlabBuild<CR>',   'Build project file'        },
  ['<F17>'] = { ':TexlabForward<CR>', 'Do forward search on pdf'  },
  ['<F29>'] = { ':VimtexClean<CR>',   'Clean build'  },
})
