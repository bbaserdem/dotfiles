--[[------------------------------------------------------------------------]]--
--[[------------------------ SUMNEKO lua LSP -------------------------------]]--
--[[------------------------------------------------------------------------]]--

return function(opts)
  -- Create scaffold
  if not opts.settings then
    opts.settings = {}
  end
  if not opts.settings.Lua then
    opts.settings.Lua = {}
  end
  if not opts.settings.Lua.runtime then
    opts.settings.Lua.runtime = {}
  end
  if not opts.settings.Lua.diagnostics then
    opts.settings.Lua.diagnostics = {}
  end
  if not opts.settings.Lua.workspace then
    opts.settings.Lua.workspace = {}
  end
  if not opts.settings.Lua.telemetry then
    opts.settings.Lua.telemetry= {}
  end
  -- Overwrite options
  opts.settings.Lua.runtime.version = 'LuaJIT'
  opts.settings.Lua.diagnostics.globals = { 'vim' }
  opts.settings.Lua.workspace.library = vim.api.nvim_get_runtime_file("", true)
  opts.settings.Lua.workspace.checkThirdParty = false
  opts.settings.Lua.telemetry.enable = false
  -- Disable this plugin
  opts.filetypes = {}
end
