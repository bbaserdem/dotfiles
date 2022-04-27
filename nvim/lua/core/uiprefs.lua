----------------------
--- * UI Options * ---
----------------------
local set = vim.opt
local win = vim.wo
local com = vim.cmd

-- Theme settings
--[[------------------------------------------------------------------------]]--
--[[----------------------------- Colorscheme ------------------------------]]--
--[[------------------------------------------------------------------------]]--
set.termguicolors = true              -- For most themes
set.background = 'dark'               -- Default to dark themes
com("let g:gruvbox_material_background = 'soft'")
com('colorscheme nvcode')  -- Default theme

--[[------------------------------------------------------------------------]]--
--[[------------------------------ Neovim UI -------------------------------]]--
--[[------------------------------------------------------------------------]]--
set.cmdheight = 2                   -- Command bar height
set.relativenumber = true           -- Show relative numbers on other lines
set.showmatch = true                -- Show matching brackets
set.laststatus = 2                  -- Always show status bar
set.splitbelow = true               -- Horizontal splits are put below
set.splitright = true               -- Vertical splits are put on the right
set.scrolloff = 5                   -- Always lines below the cursor
set.cursorcolumn = true             -- Highlight current column
set.cursorline = true               -- Highlight current row
set.showtabline = 2                 -- Always show tabs
set.signcolumn = 'yes'              -- Always show tabs
set.conceallevel = 0                -- Don't conceal any characters
set.linebreak = true                -- Auto break long lines
set.breakindent = true              -- Wrapped lines should keep indents
set.list = false                    -- Show line characters
set.listchars:append("eol:↴")       -- Put EoL character at end of line
set.listchars:append("space:⋅")     -- Put dots in mid-line spaces

--[[------------------------------------------------------------------------]]--
--[[--------------------------- Window Options -----------------------------]]--
--[[------------------------------------------------------------------------]]--
win.number = true           -- Show line number on current line
win.colorcolumn = '80'      -- Highlight limiting column
