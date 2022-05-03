---------------------------
--- LuaLine: Status bar ---
---------------------------
local gps = require("nvim-gps")
local lualine = require('lualine')

-- LSP clients
local function lsp_client_names()
    local clients = {}
    for _, client in pairs(vim.lsp.buf_get_clients(0)) do
        clients[#clients + 1] = client.name
    end
    return table.concat(clients, ' '), ' '
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'hostname', 'mode'},
    lualine_b = {gps.get_location},
    lualine_c = {lsp_client_names},
    lualine_x = {'branch', 'diff'},
    lualine_y = {'fileformat', 'filetype'},
    lualine_z = {'filesize', 'progress'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
