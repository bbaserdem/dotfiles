--[[-----------------------------------------------------------------------]]--
--[[----------------------------CORE FILES---------------------------------]]--
--[[-----------------------------------------------------------------------]]--

local core_modules = {
  -- Main settings in this order
  'core/options',
  'core/uiprefs',
  'core/fndefns',
  'core/keymaps',
}

for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
      return
    end
end
