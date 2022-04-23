-----------------
--- Nvim Tree ---
-----------------
local plug = require('nvim-tree')
return plug.setup({
  open_on_setup = true,
  open_on_setup_file = false,
  open_on_tab = true,
  view = {
    width = 20,
    side = "right",
    preserve_window_proportions = false,
    number = false,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
})
