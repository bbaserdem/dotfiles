--[[
  _       _____ _____     _____
 | |     / ____|  __ \   / ____|
 | |    | (___ | |__) | | (___   ___ _ ____   _____ _ __ ___
 | |     \___ \|  ___/   \___ \ / _ \ '__\ \ / / _ \ '__/ __|
 | |____ ____) | |       ____) |  __/ |   \ V /  __/ |  \__ \
 |______|_____/|_|      |_____/ \___|_|    \_/ \___|_|  |___/

 This file contains links to my LSP server config
--]]
local lspconfig = require("lspconfig")
local nvim_command = vim.api.nvim_command
local nvim_autocommand = vim.api.nvim_create_autocmd

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
function common_config.common_on_attach(client, bufnr)
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

--[[------------------------------------------------------------------------]]--
--[[------------------------LSP SERVERS SETUP-------------------------------]]--
--[[------------------------------------------------------------------------]]--
local lspconfig = require('lspconfig')
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

--[[.For Lua; use sumneko's lua LSP ........................................]]--
lspconfig.sumneko_lua.setup {
	--cmd = { "/usr/bin/lua-language-server" },
  on_attach = common_config.common_on_attach,
  --capabilities = common_config.capabilities,
  filetypes = { 'lua' },
	rootPatterns = { '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim', 'Config'},
      },
      workspace = {
        --library = vim.api.nvim_get_runtime_file("", true),
        library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true},
        maxPreload = 10000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

--[[.For LaTeX, use texlab for code helping and compiling...................]]--
require('texlabconfig').setup({
  config = {
    cache_activate = true,
    cache_filetypes = { 'tex', 'bib' },
    cache_root = vim.fn.stdpath('cache'),
    reverse_search_edit_cmd = 'edit',
    file_permission_mode = 438,
  },
})
lspconfig.texlab.setup{
  cmd = { "texlab" },
  on_attach = common_config.common_on_attach,
  --capabilities = common_config.capabilities,
  filetypes = { 'tex', 'bib', 'plaintex', 'latex' },
	rootPatterns = { ".git" },
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      build = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        forwardSearchAfter = true,
        onSave = false,
      },
      chktex = {
        onEdit = true,
        onOpenAndSave = true,
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        executable = "zathura",
        args = {
          '--synctex-editor-command',
          [[nvim --headless -c "TexlabInverseSearch '%{input}' %{line}"]],
          '--synctex-forward',
          '%l:1:%f',
          '%p',
        },
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = true,
      },
    },
  },
}

--[[.For LaTeX and markdown, use LTeX for grammar checking..................]]--
lspconfig.ltex.setup({
  cmd = { "ltex-ls" },
  on_attach = common_config.common_on_attach,
  --capabilities = common_config.capabilities,
  filetypes = { 'tex', 'bib', 'plaintex', 'latex',
    'gitcommit', 'markdown', 'org', 'rst', 'rnoweb',
  },
  -- root_dir = "",
  -- get_language_id = "",
  single_file_support = true,
})
