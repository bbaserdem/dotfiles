-------------------------------
--- MARKDOWN filetype stuff ---
-------------------------------
-- Custom keybinds
local wk = require('which-key')
wk.register({
  [ '<F5>'] = { ':MarkdownPreview<CR>', 'Generate html file'  },
  ['<F17>'] = { ':Glow<CR>',            'Preview in window.'  },
})
-- Navigating away from buffers save them
vim.api.nvim_create_autocmd( 'FileType', {
  group = vim.api.nvim_create_augroup( 'MarkdownAutoSave', { clear = true, }),
  pattern = {'markdown'},
  command = 'set autowriteall',
})
-- Do syntax highlighting for infinite distance
vim.api.nvim_create_autocmd( 'FileType', {
  group = vim.api.nvim_create_augroup( 'MarkdownHighlight', { clear = true, }),
  pattern = {'markdown'},
  command = 'syntax sync fromstart',
})

