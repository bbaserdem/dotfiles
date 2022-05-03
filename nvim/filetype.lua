--[[
    _______ __     __
   / ____(_/ ___  / /___  ______  ___  _____
  / /_  / / / _ \/ __/ / / / __ \/ _ \/ ___/
 / __/ / / /  __/ /_/ /_/ / /_/ /  __(__  )
/_/   /_/_/\___/\__/\__, / .___/\___/____/
                   /____/_/
--]]
-- Filetype detection
vim.filetype.add({
  filename = {
    ['sway/config'] = 'sway',
    ['waybar/config'] = 'json',
    ['waybar/style.css'] = 'css',
  },
  pattern = {
    ['.*/Stignore/.*'] = 'stignore',
    ['.*sway/config.d/.*'] = 'sway',
  },
})
