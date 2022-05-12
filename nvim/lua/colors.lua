--    _   __                _              ______            _____
--   / | / /__  ____ _   __(_)___ ___     / ____/___  ____  / __(_)___ _
--  /  |/ / _ \/ __ \ | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
-- / /|  /  __/ /_/ / |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
--/_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
--                                                             /____/
local onedark = require('onedark')

--[[------------------------------------------------------------------------]]--
--[[--------------------------- Dark Colorscheme ---------------------------]]--
--[[------------------------------------------------------------------------]]--
-- Default dark theme
vim.opt.termguicolors = true              -- For most themes
onedark.setup({
    style = 'warmer',
    transparent = true,
    term_colors = true,
    ending_tildes = true,
    cmp_itemkind_reverse = false,
    toggle_style_key = nil,
    toggle_style_list = {'light', 'warmer', 'darker'},
    code_style = {
        comments = 'italic',
        keywords = 'bold',
        functions = 'none',
        strings = 'none',
        variables = 'none',
    },
    diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
    },
})
onedark.load()
--[[------------------------------------------------------------------------]]--
--[[--------------------------- Light Colorscheme --------------------------]]--
--[[------------------------------------------------------------------------]]--
-- Default light theme
vim.g.tokyonight_style = 'day'
vim.g.tokyonight_terminal_colors = 'true'
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = true
vim.g.tokyonight_hide_inactive_statusline = false
vim.g.tokyonight_sidebars = {
    'qf',
    'vista_kind',
    'terminal',
    'packer',
}
vim.g.tokyonight_transparent_sidebar = false
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_day_brightness = 0.25
vim.g.tokyonight_lualine_bold = true
