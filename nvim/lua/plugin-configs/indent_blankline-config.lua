---------------------------
--- Indentline Settings ---
---------------------------
local plug = require('indent_blankline')
return plug.setup({
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
})
