--[[
    _   __      _              ______            _____
   / | / _   __(_____ ___     / ________  ____  / __(_____ _
  /  |/ | | / / / __ `__ \   / /   / __ \/ __ \/ /_/ / __ `/
 / /|  /| |/ / / / / / / /  / /___/ /_/ / / / / __/ / /_/ /
/_/ |_/ |___/_/_/ /_/ /_/   \____/\____/_/ /_/_/ /_/\__, /
                                                   /____/
from https://patorjk.com/software/taag/#p=display&h=3&f=Slant
--]]

local core_modules = {
  -- Main settings
  'plugins',
  'servers',
  'keybinds',
  'options',
}

-- Using pcall we can handle loading issues
for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
			return
    end
end
