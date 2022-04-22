--[[------------------------------------------------------------------------]]--
--[[------------------------ SUMNEKO lua LSP -------------------------------]]--
--[[------------------------------------------------------------------------]]--
local common_config = require('core/servers')
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

--[[.For Lua; use sumneko's lua LSP ........................................]]--
require'lspconfig'.sumneko_lua.setup {
	cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  log_level = 2,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
        --library = {[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				--[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true},
        --maxPreload = 10000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  single_file_support = true,
  --on_attach = common_config.on_attach,
  --capabilities = common_config.capabilities,
	--rootPatterns = { '.git' },
}
