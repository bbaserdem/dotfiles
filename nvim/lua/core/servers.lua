--[[
  _       _____ _____     _____
 | |     / ____|  __ \   / ____|
 | |    | (___ | |__) | | (___   ___ _ ____   _____ _ __ ___
 | |     \___ \|  ___/   \___ \ / _ \ '__\ \ / / _ \ '__/ __|
 | |____ ____) | |       ____) |  __/ |   \ V /  __/ |  \__ \
 |______|_____/|_|      |_____/ \___|_|    \_/ \___|_|  |___/

 This file contains links to my LSP server config
--]]
--local lspconfig = require("lspconfig")
--local nvim_command = vim.api.nvim_command

--local nvim_autocommand = vim.api.nvim_create_autocmd

--[[------------------------------------------------------------------------]]--
--[[------------------------COMMON CONFIGURATION----------------------------]]--
--[[------------------------------------------------------------------------]]--

local common_config = {}

--[[.Gutter signs for diagnostic prompts....................................]]--
local signs = {
  Error   =   "",
  Warn    =   "",
  Hint    =   "ﯦ",
  Info    =   "",
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--[[.Diagnostics configuration..............................................]]--
vim.diagnostic.config({
  underline = true,
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
    source = "if_many",
  },
  signs = true,
  update_in_insert = false,
  float = {
    source = 'always',
    scope = 'cursor',
    border = 'single',
    header = '',
    prefix = '',
    focusable = false,
  },
  severity_sort = true,
})

--[[.Hover popup config.....................................................]]--
function common_config.on_attach(client, bufnr)
  vim.api.nvim_create_autocmd( "CursorHold",
    { buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = {
            "BufLeave",
            "CursorMoved",
            "InsertEnter",
            "FocusLost"
          },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(opts)
      end,
    }
  )
end


--[[.Common server keymaps..................................................
local function key_maps(bufnr)
	-- Mappings.
	local opts = { buffer=bufnr, noremap=true, silent=true }

	local maps = {
		["<leader>l"] = {
			name = "Lsp",
			a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
			D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
			k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
			h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Help" },
			n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
			r = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
			l = { "<cmd>lua vim.diagnostic.open_float({scope = 'line'})<CR>", "Show Diagnostics" },
		},
		["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostics" },
		["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostics" }
	}

	require("which-key").register(maps, opts);
end]]--

return common_config
