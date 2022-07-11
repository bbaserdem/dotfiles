--    _   __                _              ______            _____
--   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
--  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
-- / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
--/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
--                                                             /____/
local set = vim.opt
local com = vim.cmd
local g = vim.g
local win = vim.wo

--[[------------------------------------------------------------------------]]--
--[[----------------------------- Performance ------------------------------]]--
--[[------------------------------------------------------------------------]]--
set.encoding = 'utf-8'      -- Show files in UTF8
set.fileencoding = 'utf-8'  -- Write files in UTF8
set.updatetime = 250        -- Swap file after this many milliseconds
set.timeoutlen = 500        -- Which key hijacks this in half a second
set.ttimeoutlen = 100       -- But not keycodes
set.mouse = 'a'             -- Enable mouse
set.autoread = true         -- Reload changed files
set.hidden = true           -- Keep buffers open in background
set.undofile = true         -- Keep history of edits
g.do_filetype_lua = 1       -- Use filetype.lua

--[[------------------------------------------------------------------------]]--
--[[--------------------------------- Typing -------------------------------]]--
--[[------------------------------------------------------------------------]]--
set.spelllang = 'en_us'     -- Default to english
set.ignorecase = true       -- Search case insensitive
set.smartcase = true        -- ... unless the query has capital letters
set.autoindent = true       -- Allow autoindent
set.expandtab = true        -- Insert spaces when TAB is pressed
set.tabstop = 8             -- Render actual tabs using this many spaces.
set.softtabstop = 4         -- Default to tabs being 4 spaces wide
set.shiftwidth = 4          -- Default to indenting 4 spaces in
set.joinspaces = false      -- Don't insert 2 spaces on (J)oin
com('set formatoptions+=o') -- Continue comments with comment prefix

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
set.wrap = true                     -- Auto break long lines
set.textwidth = 0                   -- Limit text width to 80
set.breakindent = true              -- Wrapped lines should keep indents
set.list = false                    -- Show line characters
set.listchars:append("eol:↴")       -- Put EoL character at end of line
set.listchars:append("space:⋅")     -- Put dots in mid-line spaces
set.listchars:append("tab:>-")
set.listchars:append("trail:-")
set.listchars:append("extends:>")
set.listchars:append("precedes:<")
set.listchars:append("nbsp:+")

--[[------------------------------------------------------------------------]]--
--[[--------------------------- Window Options -----------------------------]]--
--[[------------------------------------------------------------------------]]--
win.number = true           -- Show line number on current line
win.colorcolumn = '80'      -- Highlight limiting column
