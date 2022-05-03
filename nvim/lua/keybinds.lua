------------------------
--  General Mappings  --
------------------------

-- Shorten function name
local keymap = vim.keymap.set
local term_opts = { silent = true }

-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-----------------
--- Shortcuts ---
-----------------
-- Copy paste from clipboard
keymap({ 'v'    }, '<C-c>', '"+y', term_opts)
keymap({'n', 'v'}, '<C-v>', '"+p', term_opts)
-- Search and replace
keymap('n', '<Leader>s', ':%s///g<Left><Left><Left>')
-- Clear highlight
keymap('n', '<Leader>/', ':nohlsearch<CR>', term_opts)

------------------------------
--- Normal Mode Navigation ---
------------------------------
-- Window navigation
keymap('n', '<leader>j', ':wincmd j<CR>', term_opts)
keymap('n', '<leader>k', ':wincmd k<CR>', term_opts)
keymap('n', '<leader>l', ':wincmd l<CR>', term_opts)
keymap('n', '<leader>h', ':wincmd h<CR>', term_opts)
-- Tab navigation
keymap('n', '<leader>H', ':tabprev <CR>', term_opts)
keymap('n', '<leader>L', ':tabnext <CR>', term_opts)
-- Buffer navigation
keymap('n', '<leader>J', ':bprev <CR>', term_opts)
keymap('n', '<leader>K', ':bnext <CR>', term_opts)
-- SEEKING
-- List buffers to navigate current window to them
keymap('n', '<Leader><Tab>', ':Telescope buffers<CR>', term_opts)
-- Close this buffer
keymap('n', '<leader>d', ':Bdelete <CR>', term_opts)
-- Close this window/tab
keymap('n', '<leader>q', ':close <CR>', term_opts)
keymap('n', '<leader>Q', ':tabclose <CR>', term_opts)
-- Find an open new buffer from files, or a new one
keymap('n', '<Leader>o', ':Telescope find_files<CR>', term_opts)
keymap('n', '<Leader>O', ':enew <CR>', term_opts)
-- New tab, while retaining the current layout or not
keymap('n', '<Leader>n', ':tab split<CR>', term_opts)
keymap('n', '<Leader>N', ':tabnew <CR>', term_opts)
-- New windows
keymap('n', '<Leader>,', ':split <CR>', term_opts)
keymap('n', '<Leader>.', ':vsplit <CR>', term_opts)

---------------------
--- LSP Functions ---
---------------------
keymap('n', '<Leader>c',    vim.lsp.buf.clear_references, term_opts)
keymap('n', '<Leader>r',    vim.lsp.buf.code_action,      term_opts)
keymap('n', '<Leader>w',    vim.lsp.buf.declaration,      term_opts)
keymap('n', '<Leader>?',    vim.lsp.buf.definition,       term_opts)
keymap('n', '<Leader>f',    vim.lsp.buf.document_symbol,  term_opts)
keymap('n', "<Leader>'",    vim.lsp.buf.hover,            term_opts)
keymap('n', '<Leader>i',    vim.lsp.buf.references,       term_opts)
keymap('n', '<Leader>I',    vim.lsp.buf.declaration,      term_opts)
keymap('n', '<Leader>u',    vim.lsp.buf.incoming_calls,   term_opts)
keymap('n', '<Leader>U',    vim.lsp.buf.outgoing_calls,   term_opts)
keymap('n', '<Leader>a',    vim.lsp.buf.signature_help,   term_opts)
keymap('n', '<Leader>A',    vim.lsp.buf.type_definition,  term_opts)
keymap('n', '<Leader><CR>', vim.lsp.buf.rename,           term_opts)

---------------------
--- Function Keys ---
---------------------
-- Each keybind respectively is clear, shift, ctrl and shift-ctrl.
-- Modifiers add to function keys, multiplying them
---- Shift is +12
---- Ctrl  is +24
---- Both  is +36
---- Alt   is +48 (Don't use alt in keybinds in general)
-- Meta is not sent through, and ctrl alt fN are OS shortcuts for consoles

-- 01: Help, as in documentation and whatnot.
keymap('n', '<F13>',  ':TroubleToggle lsp_definitions<CR>',           term_opts)
keymap('n', '<F25>',  ':TroubleToggle lsp_references<CR>',            term_opts)
keymap('n', '<F37>',  ':TroubleToggle lsp_type_definitions<CR>',      term_opts)
-- 02: Hint, as in provide info about functionality
keymap('n', '<F2>' ,  ':Glow $XDG_CONFIG_HOME/nvim/Keymap.md<CR>',    term_opts)
keymap('n', '<F26>',  ':LspInfo<CR>',                                 term_opts)
keymap('n', '<F38>',  ':LspInstallInfo<CR>',                          term_opts)
-- 03: Graphical options
keymap('n', '<F3>' ,  ':Twilight<CR>',                                term_opts)
keymap('n', '<F15>',  ':TZAtaraxis<CR>',                              term_opts)
--keymap('n', '<F27>', ':<CR>',  term_opts)
keymap('n', '<F39>',  ':Telescope colorschemes<CR>',                  term_opts)
-- 04: Context menus
keymap('n', '<F4>',   ':NvimTreeToggle<CR>',                          term_opts)
keymap('n', '<F16>',  ':TroubleToggle workspace_diagnostics<CR>',     term_opts)
keymap('n', '<F28>',  ':SymbolsOutline<CR>',                          term_opts)

-- 05: Build (this is usually individual to file-type)
-- 06: Comments
keymap('n', '<F6>',   ':<Plug>(comment_toggle_current_linewise)<CR>', term_opts)
keymap('x', '<F6>',   ':<Plug>(comment_toggle_current_blockwise)<CR>',term_opts)

-- 07: Git actionshttps://patorjk.com/software/taag/#p=display&h=3&f=Slant
-- 08: Snippets
