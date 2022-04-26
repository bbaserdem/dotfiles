---------------------
--- Texlab Config ---
---------------------
local texlabconfig = require('texlabconfig')
-- Allows for there to be inverse search from pdf to texlab lsp server
local config = {
    cache_activate = true,
    cache_filetypes = {
      'tex',
      'bib',
      --'plaintex',
      --'latex',
    },
    cache_root = vim.fn.stdpath('cache'),
    reverse_search_edit_cmd = 'edit',
    file_permission_mode = 438,
}
texlabconfig.setup(config)
