----------------------
--- Autocompletion ---
----------------------
--Preload
local plug = require('cmp')
local plug_ulti_ok, plug_ulti = pcall(require, 'cmp_nvim_ultisnips')
local plug_lspk_ok, plug_lspk = pcall(require, 'lspkind')

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
  local context = require('cmp.config.context')
  if vim.api.nvim_get_mode().mode == 'c' then
    return true
  else
    return not context.in_treesitter_capture("comment")
      and not context.in_syntax_group("Comment")
  end
end

-- I don't know but gathered this around
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local tc = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return plug.setup({
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
    format = plug_lspk.cmp_format {
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
    documentation = plug.config.window.bordered(),
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
    ["<Tab>"] = plug.mapping({
      i = function(fallback)
        if plug.visible() then           -- If menu is open, navigate next
          plug.select_next_item({ behavior = plug.SelectBehavior.Insert })
        elseif has_words_before() then
          plug.complete()
        else                            -- Do whatever
          fallback()
        end
      end,
      c = function()
        if plug.visible() then           -- If menu is open, navigate next
          plug.select_next_item({ behavior = plug.SelectBehavior.Insert })
        else                            -- Open completion
          plug.complete()
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
    ["<S-Tab>"] = plug.mapping({
      i = function(fallback)
        if plug.visible() then           -- If menu is open, navigate next
          plug.select_prev_item({ behavior = plug.SelectBehavior.Insert })
        else                            -- Do whatever
          fallback()
        end
      end,
      c = function()
        if plug.visible() then           -- If menu is open, navigate next
          plug.select_prev_item({ behavior = plug.SelectBehavior.Insert })
        else                            -- Open completion
          plug.complete()
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
    ['<CR>'] = plug.mapping({
      i = function(fallback)
        if plug.visible() then
          plug.confirm({behavior = plug.ConfirmBehavior.Replace, select = false})
        else
          fallback()
        end
      end,
      c = function(fallback)
        if plug.visible() then
          plug.confirm({behavior = plug.ConfirmBehavior.Replace, select = false})
        else
          fallback()
        end
      end,
    }),
    ['<Down>'] = plug.mapping({
      i = function(fallback)
        if plug.visible() then
          plug.select_next_item({ behavior = plug.SelectBehavior.Select })
        else
          fallback()
        end
      end,
      c = function(fallback)
        if plug.visible() then
          plug.select_next_item({ behavior = plug.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
    ['<Up>'] = plug.mapping({
      i = function(fallback)
        if plug.visible() then
          plug.select_prev_item({ behavior = plug.SelectBehavior.Select })
        else
          fallback()
        end
      end,
      c = function(fallback)
        if plug.visible() then
          plug.select_prev_item({ behavior = plug.SelectBehavior.Select })
        else
          fallback()
        end
      end,
    }),
  },

  sorting = {
    comparators = {
      plug.config.compare.offset,
      plug.config.compare.exact,
      plug.config.compare.score,

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

      plug.config.compare.kind,
      plug.config.compare.sort_text,
      plug.config.compare.length,
      plug.config.compare.order,
    },
  },
})
