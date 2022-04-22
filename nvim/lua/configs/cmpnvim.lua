----------------------
--- Autocompletion ---
----------------------
--Preload
local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then
  return
end
local ultisnips_status_ok, ultisnips = pcall(require, 'cmp_nvim_ultisnips')
local lspkind_status_ok, lspkind = pcall(require, 'lspkind')

-- Ultisnips config
if ultisnips_status_ok then
  vim.g.UltiSnipsExpandTrigger            = '<Plug>(ultisnips_expand)'
  vim.g.UltiSnipsJumpForwardTrigger       = '<Plug>(ultisnips_jump_forward)'
  vim.g.UltiSnipsJumpBackwardTrigger      = '<Plug>(ultisnips_jump_backward)'
  vim.g.UltiSnipsListSnippets             = '<c-x><c-s>'
  vim.g.UltiSnipsRemoveSelectModeMappings = 0
end

-- Check for backspace
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- Check if there is a word before this
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(
    0,
    line - 1,
    line,
    true
  )[1]:sub(col, col):match("%s") == nil
end

-- Check for comment block while not in command mode
local check_comment = function()
  local context = require 'cmp.config.context'
  if vim.api.nvim_get_mode().mode == 'c' then
    return true
  else
    return not context.in_treesitter_capture("comment")
      and not context.in_syntax_group("Comment")
  end
end

-- ???
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local tc = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return cmp.setup {
  -- Enable when not in comment block
  enabled = check_comment(),
  -- Sources for completion
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "ultisnips" },
    { name = "buffer" },
  },
  -- Menu type
  view = {
    entries = {
      name = 'custom',
      selection_order = 'near_cursor',
    },
  },
  -- Display
  formatting = {
    format = lspkind.cmp_format {
      mode = "symbol_text",
      menu = {
        buffer = "[buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[path]",
        ultisnips = "[UltiSnips]",
      },
    },
  },
  -- Window
  window = {
    documentation = cmp.config.window.bordered(),
  },
  -- Experiment
  experimental = {
    ghost_text = false,
  },
  mapping = {
    -- Tab
    -- Insert mode:
    --    Navigate menu (if open)
    --    Open menu (if not open)
    --    Insert white space
    -- Command mode:
    --    Navigate menu (if open)
    --    Open menu (if not open)
    -- Select mode (UltiSnips)
    --    If in a snippet; move to next item
    -- Shift-Tab
    -- Insert mode:
    --    Navigate menu (if open)
    --    Backspace
    -- Command mode:
    --    Navigate menu (if open)
    --    Backspace
    -- Select mode (UltiSnips)
    --    If in a snippet; move to prev item
    -- Vertical Arrows
    -- Insert mode:
    --    Navigate menu (if open)
    -- Command mode:
    --    Navigate menu (if open)
    -- Enter
    -- Insert mode:
    --    Confirm
    ["<Tab>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then           -- If menu is open, navigate next
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif has_words_before() then
          cmp.complete()
        else                            -- Do whatever
          fallback()
        end
      end,
      c = function()
        if cmp.visible() then           -- If menu is open, navigate next
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else                            -- Open completion
          cmp.complete()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(tc("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ["<S-Tab>"] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then           -- If menu is open, navigate next
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else                            -- Do whatever
          fallback()
        end
      end,
      c = function()
        if cmp.visible() then           -- If menu is open, navigate next
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else                            -- Open completion
          cmp.complete()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          vim.api.nvim_feedkeys(tc("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ['<CR>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})
        else
          fallback()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})
        else
          fallback()
        end
      end,
    }),
    ['<Down>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ['<Up>'] = cmp.mapping({
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
      c = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
  },

  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      function(entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find "^_+"
        local _, entry2_under = entry2.completion_item.label:find "^_+"
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },


}
