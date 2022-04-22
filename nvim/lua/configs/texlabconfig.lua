-- For backwards search
return require('texlabconfig').setup({
  config = {
    cache_activate = true,
    cache_filetypes = { 'tex', 'bib' },
    cache_root = vim.fn.stdpath('cache'),
    reverse_search_edit_cmd = 'edit',
    file_permission_mode = 438,
  },
})
