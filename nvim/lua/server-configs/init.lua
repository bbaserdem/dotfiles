--  _       _____ _____     _____
-- | |     / ____|  __ \   / ____|
-- | |    | (___ | |__) | | (___   ___ _ ____   _____ _ __ ___
-- | |     \___ \|  ___/   \___ \ / _ \ '__\ \ / / _ \ '__/ __|
-- | |____ ____) | |       ____) |  __/ |   \ V /  __/ |  \__ \
-- |______|_____/|_|      |_____/ \___|_|    \_/ \___|_|  |___/
--
-- This file contains links to my LSP server config
vim.lsp.set_log_level("debug")

-- LSP server installer, that also sets the servers up
local installer_ok, installer = pcall(require, 'nvim-lsp-installer')
if not installer_ok then
  error('Nvim-lsp-installer could not run\n' .. installer .. '\n')
end
local loader_ok, loader = pcall(require, 'lspconfig')
if not loader_ok then
  error('Nvim-lspconfig could not run\n' .. loader .. '\n')
end

local local_servers = {
  -- Awk
  'awk_ls',
  -- Bash
  'bashls',
  -- C, C++
  'clangd',
  -- Cmake
  'cmake',
  -- JSON
  'jsonls',
  -- Lua
  --'sumneko_lua',
  -- Latex
  'texlab',
  -- Markdown
  'prosemd_lsp',
  -- Python
  'pylsp',
  'sourcery',
  -- Spellcheck
  'ltex',
}

--[[------------------------------------------------------------------------]]--
--[[------------------------- VIM TYPE CONFIGS -----------------------------]]--
--[[------------------------------------------------------------------------]]--

--[[.....Gutter signs for diagnostic prompts................................]]--
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

--[[.....Diagnostics prompt configuration...................................]]--
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
    header = '',
    prefix = ' ',
  },
  severity_sort = true,
})

--[[.....LSP Installer settings.............................................]]--
installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

--[[------------------------------------------------------------------------]]--
--[[----------------------- COMMON CONFIGURATION ---------------------------]]--
--[[------------------------------------------------------------------------]]--
local spinner_ok, spinner = pcall(require, 'lsp_spinner')

--[[.....Buffer-local options to apply on attach............................]]--
function common_on_attach(client, bufnr)
  vim.api.nvim_create_autocmd( 'CursorHold', {
    group = vim.api.nvim_create_augroup('LspHoverOnCursor', { clear = true, }),
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = {
          'BufLeave',
          'CursorMoved',
          'InsertEnter',
          'FocusLost',
        },
        border = 'rounded',
      }
      vim.diagnostic.open_float(opts)
    end
  })
  if spinner_ok then
    spinner.on_attach(client, buffer)
  end
end

-- Get capabilities
local cmp_lsp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_lsp_ok then
  common_capabilities = cmp_lsp.update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
else
  common_capabilities = {}
end
if spinner_ok then
  spinner.init_capabilities(common_capabilities)
end

--[[------------------------------------------------------------------------]]--
--[[--------------------- LOCAL SERVER APPLICATION -------------------------]]--
--[[------------------------------------------------------------------------]]--
-- Auto install these servers using lsp_installer
for _, name in pairs(local_servers) do
  local server_is_found, server = installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end
-- Configure these servers
installer.on_server_ready(function(server)
  -- Load server opts if we can
  local this_opts_ok, this_opts = pcall(require,
    'server-configs/' .. server.name .. '-config'
  )
  if this_opts_ok then
    this_opts.on_attach = common_on_attach
    this_opts.capabilities = common_capabilities
  else
    this_opts = {
      on_attach = common_on_attach,
      capabilities = common_capabilities,
    }
  end

  -- Set this server up
  server:setup(this_opts)
end)
