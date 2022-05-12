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
    extension = {
        sty = 'latex',
        cls = 'latex',
    },
    filename = {
        ['sway/config'] = 'sway',
        ['waybar/config'] = 'json',
        ['waybar/style.css'] = 'css',
    },
    pattern = {
        ['.*/Stignore/.*'] = 'stignore',
        ['.*sway/config.d/.*'] = 'sway',
        -- ['.*'] = function(path, bufnr)
        --     if vim.fn.getline(bufnr, -1):match('#!.*dash') then
        --         return 'dash'
        --     end
        -- end,
    },
})
