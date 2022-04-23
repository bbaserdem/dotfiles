--    _   __                _              ______            _____
--   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
--  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
-- / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
--/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
--                                                             /____/
local set = vim.opt

--[[------------------------------------------------------------------------]]--
--[[----------------------------- Performance ------------------------------]]--
--[[------------------------------------------------------------------------]]--
set.encoding = 'utf-8'      -- Show files in UTF8
set.fileencoding = 'utf-8'  -- Write files in UTF8
set.updatetime = 250        -- Swap file after this many milliseconds
set.timeoutlen = 3000       -- Make chords timeout in 3 secs instead
set.ttimeoutlen = 100       -- But not keycodes
set.mouse = 'a'             -- Enable mouse
set.autoread = true         -- Reload changed files
set.hidden = true           -- Keep buffers open in background
set.undofile = true         -- Keep history of edits

--[[------------------------------------------------------------------------]]--
--[[--------------------------------- Typing -------------------------------]]--
--[[------------------------------------------------------------------------]]--
set.spelllang = 'en_US'     -- Default to english
set.ignorecase = true       -- Search case insensitive
set.smartcase = true        -- ... unless the query has capital letters
set.autoindent = true       -- Allow autoindent
set.expandtab = true        -- Insert spaces when TAB is pressed
set.tabstop = 8             -- Render actual tabs using this many spaces.
set.softtabstop = 4         -- Default to tabs being 4 spaces wide
set.shiftwidth = 4          -- Default to indenting 4 spaces in
set.joinspaces = false      -- Don't insert 2 spaces on (J)oin
vim.cmd 'set formatoptions+=o'  -- Continue comments with comment prefix
