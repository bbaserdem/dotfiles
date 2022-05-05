------------------------
--  General Mappings  --
------------------------
local wk = require('which-key')

-- Remap space as leader key
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- Make wrapper around lsp functions
local lsp_fun = function (name)
  vim.lsp.buf[name]()
end

-- Normal mode keymaps
wk.register({
  w = {
    name = 'Window navigation',
    j = { ':wincmd j<CR>',  'Move to window down'                   },
    k = { ':wincmd k<CR>',  'Move to window up'                     },
    l = { ':wincmd l<CR>',  'Move to window right'                  },
    n = { ':split <CR>',    'Open a new window as horizontal split' },
    v = { ':vsplit <CR>',   'Open a new window as vertical split'   },
    d = { ':close <CR>',    'Close this window'                     },
  },
  t = {
    name = 'Tab navigation',
    h = { ':tabprev <CR>',    'Move to previous tab'              },
    l = { ':tabnext <CR>',    'Move to next tab'                  },
    n = { ':tabnew <CR>',     'Open new tab'                      },
    o = { ':tab split <CR>',  'Open new tab with current buffer'  },
    d = { ':tabclose <CR>',   'Close tab'                         },
  },
  b = {
    name = 'Buffer navigation',
    j = { ':bprev <CR>',                'Previous buffer'           },
    k = { ':bnext <CR>',                'Next buffer'               },
    a = { ':Telescope buffers<CR>',     'Active buffer list'        },
    d = { ':Bdelete <CR>',              'Close buffer'              },
    o = { ':Telescope find_files<CR>',  'Open new buffer from file' },
    n = { ':enew',                      'Open a new empty buffer'   },
  },
  l = {
    name = 'LSP functions',
    c = { lsp_fun('clear_references'),      'Remove document highlights'      },
    a = { lsp_fun('code_action'),           'Select a code action'            },
    D = { lsp_fun('declaration'),           'Jump to symbol declaration'      },
    d = { lsp_fun('definition'),            'Jump to symbol definition'       },
    h = { lsp_fun('document_highlight'),    'Resolve document highlights'     },
    s = { lsp_fun('document_symbol'),       'List symbols in quickfix window' },
    ['?'] = { lsp_fun('hover'),             'Open hover menu'                 },
    u = { lsp_fun('implementation'),        'List all implementations'        },
    N = { lsp_fun('incoming_calls'),        'List all call sites'             },
    f = { lsp_fun('list_workspace_folders'),'List workspace folders'          },
    n = { lsp_fun('outgoing_calls'),        'List all called sites'           },
    r = { lsp_fun('rename'),                'Rename the symbol and all refs.' },
    S = { lsp_fun('signature_help'),        'Display signature info'          },
    t = { lsp_fun('type_definition'),       'Go to the definition of the type'},
    i = { ':LspInfo<CR>',                   'LSP information menu'            },
    I = { ':LspInstallInfo<CR>',            'LSP installer information menu'  },
    q = { ':LspStop<CR>',                   'Stop all buffer LSP clients'     },
    Q = { ':LspRestart<CR>',                'Restart all buffer LSP clients'  },
    ['.'] = { ':LspStart<CR>',              'Start all relevant servers'      },
  },
--]]
  m = {
    name = 'Extrenal menus',
    e = { ':Trouble workspace_diagnostics<CR>', 'Show errors in workspace'    },
    E = { ':Trouble document_diagnostics<CR>',  'Show errors everywhere'      },
    r = { ':Trouble lsp_references<CR>',        'Show references from LSP'    },
    d = { ':Trouble lsp_definitions<CR>',       'Show definitions from LSP'   },
    D = { ':Trouble lsp_type_definitions<CR>',  'Show tuple defs from LSP'    },
    q = { ':Trouble quickfix<CR>',              'Show quickfix list'          },
    l = { ':Trouble loclist<CR>',               'Show location list'          },
    t = { ':NvimTreeToggle<CR>',                'Files menu'                  },
    s = { ':SymbolsOutline<CR>',                'Symbols overview'            },
  },
  v = {
    name = 'Visuals',
    z = { ':TZAtaraxis<CR>',            'Activate heavy zen mode'     },
    Z = { ':TZMinimalist<CR>',          'Activate light zen mode'     },
    f = { ':TZFocus<CR>',               'Activate focus zen mode'     },
    d = { ':Twilight<CR>',              'Twilight; dim inactive code' },
    C = { ':Telescope colorscheme<CR>', 'Color theme menu.'           },
    c = { ':nohlsearch<CR>',            'Clear highlight'             },
    --m : Dark/light mode toggle
  },
  e = {
    name = 'Editing',
    r = { ':%s///g<Left><Left><Left>',  'Search and replace'          },
    p = { '"+p',                        '(Paste) Put from clipboard'  },
    c = {
      '<CMD>lua require("Comment.api").call("toggle_current_linewise_op")<CR>g@$',
      'Comment this line'
    },
    C = {
      '<CMD>lua require("Comment.api").call("toggle_current_blockwise_op")<CR>g@$',
      'Comment this line in a block'
    },
    k = {
      '<CMD>lua require("Comment.api").call("toggle_current_linewise_op")<CR>g@',
      'Comment lines using movement.'
    },
    K = {
      '<CMD>lua require("Comment.api").call("toggle_current_blockwise_op")<CR>g@',
      'Comment lines in a block using movement'
    },
  },
}, {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})
-- Visual mode keymaps
wk.register({
  e = {
    name = 'Editing',
    y = { '"+y',        '(Copy) Yank selection to clipboard'    },
    d = { '"+d',        '(Cut) Delete selection to clipboard'   },
    p = { '"+p',        '(Paste) Put to selection from clipboard'  },
    c = {
      '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
      'Comment this line'
    },
    C = {
      '<ESC><CMD>lua require("Comment.api").toggle_blockwise_op(vim.fn.visualmode())<CR>',
      'Comment this line in a block'
    },
  },
}, {
  mode = 'x',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})
