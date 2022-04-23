--  _       _____ _____     _____
-- | |     / ____|  __ \   / ____|
-- | |    | (___ | |__) | | (___   ___ _ ____   _____ _ __ ___
-- | |     \___ \|  ___/   \___ \ / _ \ '__\ \ / / _ \ '__/ __|
-- | |____ ____) | |       ____) |  __/ |   \ V /  __/ |  \__ \
-- |______|_____/|_|      |_____/ \___|_|    \_/ \___|_|  |___/
--
-- This file contains links to my LSP server config
local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok then
  return
end

-- LSP server installer
local installer_ok, installer = pcall(require, 'nvim-lsp-installer')
if not installer_ok then
  return
end

-- Separate configs are files that should return functions that;
--  Get a dictionary as an argument
--  Modify that dictionary with overrides
--  Resulting dictionary should be able to be sent as the argument to setup
--    function as lspconfig requires

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
local common_opts = {}

--[[.....Buffer-local options to apply on attach............................]]--
function common_opts.on_attach(client, bufnr)
  -- Popup, should work, but not working
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
end

--[[------------------------------------------------------------------------]]--
--[[------------------------ SERVER APPLICATION ----------------------------]]--
--[[------------------------------------------------------------------------]]--

installer.on_server_ready(function(server)
  local opts = {}

  -- Default options for all servers, copy this over
  for key, val in pairs(common_opts) do
    opts[key] = val
  end

  -- Try to load relevant server config
  local this_opts_ok, this_opts = pcall(require, server.name .. '-config')
  if this_opts_ok then
    this_opts(opts)
  end

  -- Set this server up
  server:setup(opts)
end)
