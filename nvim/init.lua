--[[--------------------------------------------------------------------]]--
--[[--------------------------INIT - init file--------------------------]]--
--[[--------------------------------------------------------------------]]--

vim.api.nvim_command('source $XDG_CONFIG_HOME/nvim/oldinit.vim')

local core_modules = {
  -- Main settings
  'core',
  -- Plugin configs
  'plugin-configs',
  -- Server configs
  'server-configs',
}

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
      return
    end
end
