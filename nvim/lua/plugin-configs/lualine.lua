---------------------------
--- LuaLine: Status bar ---
---------------------------
local gps = require('nvim-gps')
local spinner = require('lsp_spinner')
local lualine = require('lualine')

lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'codedark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {gps.get_location},
        lualine_x = {spinner.status},
        lualine_y = {'fileformat', 'filetype'},
        lualine_z = {'filesize', 'progress'},
    },
    inactive_sections = {
        lualine_a = {'hostname'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'location'},
        lualine_x = {},
        lualine_y = {'fileformat', 'filetype'},
        lualine_z = {'filesize', 'progress'}
    },
    tabline = {},
    extensions = {}
}
