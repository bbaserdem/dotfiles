---------------------------
--- Indentline Settings ---
---------------------------

-- For rainbow indent highlighting
vim.cmd( 'highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine' )
vim.cmd( 'highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine' )
vim.cmd( 'highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine' )
vim.cmd( 'highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine' )
vim.cmd( 'highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine' )
vim.cmd( 'highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine' )
local rainbow_highlights = {
  "IndentBlanklineIndent1",
  "IndentBlanklineIndent2",
  "IndentBlanklineIndent3",
  "IndentBlanklineIndent4",
  "IndentBlanklineIndent5",
  "IndentBlanklineIndent6",
}

-- The colors are set in core settings, but put guards here
local plug_ok, plug = pcall(require, 'indent_blankline')
if plug_ok then
return plug.setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = false,
  })
else
  return {}
end
