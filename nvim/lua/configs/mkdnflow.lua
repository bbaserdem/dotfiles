--[[------------------------------------------------------------------------]]--
--[[-----------------------------Mkdnflow Markdown--------------------------]]--
--[[------------------------------------------------------------------------]]--

require('mkdnflow').setup({
  create_dirs = true,
  links_relative_to = 'current',
  filetypes = {
    md = true,
    rmd = true,
    markdown = true,
    },
  wrap_to_beginning = true,
  wrap_to_end = true,
})

vim.cmd [[
augroup MkdnflowWriteMarkdown
    autocmd!
    autocmd FileType markdown set autowriteall
augroup end
]]
