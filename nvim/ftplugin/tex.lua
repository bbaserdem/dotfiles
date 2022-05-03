--------------------------
--- LaTeX file configs ---
--------------------------
local keymap = vim.keymap.set
-- Function keys to be used with latex files
keymap('n', '<F5>',   ':TexlabBuild<CR>',   { silent = true, })
-- Preview is forward search
keymap('n', '<F17>',  ':TexlabForward<CR>', { silent = true, })
-- Clean build
keymap('n', '<F41>',  ':VimtexClean<CR>',   { silent = true, })
