-------------------------------
--- MARKDOWN filetype stuff ---
-------------------------------
local keymap = vim.keymap.set
-- Navigating away from buffers save them
vim.cmd('autocmd FileType markdown set autowriteall')
vim.api.nvim_create_autocmd( 'BufWritePost', {
  group = vim.api.nvim_create_augroup( 'MarkdownSaveOnLeftBuffer', { clear = true, }),
  pattern = {'*.md', '*.MD'},
  command = 'set autowriteall',
})
-- Function keys to be used with markdow files
keymap('n', '<F5>',   ':MarkdownPreview<CR>', { silent = true, })
keymap('n', '<F17>',  ':Glow<CR>',            { silent = true, })
