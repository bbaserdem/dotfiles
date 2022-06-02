----------------------
--- Autocompletion ---
----------------------
--Preload
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- Export these
M = {}

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
    )[1]:sub(col, col):match('%s') == nil
end

-- Check for comment block while not in command mode
local check_comment = function()
    local context = require('cmp.config.context')
    if vim.api.nvim_get_mode().mode == 'c' then
        return true
    else
        return not context.in_treesitter_capture('comment')
            and not context.in_syntax_group('Comment')
    end
end


-- I don't know but gathered this around
local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local tc = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- Sources array here so that it is collected{
local completion_sources = {
    { name = 'buffer',
        option = {
            label = '[buffer]',
            keyword_length = 2,
            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
        },
    },
    { name = 'nvim_lua',
        option = {
            label = '[nvim]',
        },
    },
    { name = 'nvim_lsp',
        option = {
            label = '[lsp ]',
        },
    },
    { name = 'nvim_lsp_signature_help',
        option = {
            label = '[sign]',
        },
    },
    { name = 'path',
        option = {
            label = '[path]',
            trailing_slash = true,
        },
    },
    { name = 'tmux',
        option = {
            label = '[tmux]',
        },
    },
    { name = 'omni',
        option = {
            label = '[omni]',
        },
    },
    { name = 'luasnip',
        option = {
            label = '[snip]',
        },
    },
}
M.completion_sources = completion_sources

cmp.setup({
    -- Enable when not in comment block
    enabled = check_comment(),
    -- Sources for completion
    sources = completion_sources,
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
    -- Snippets
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end,
            c = function()
                if cmp.visible() then                     -- If menu is open, navigate next
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else                                                        -- Open completion
                    cmp.complete()
                end
            end,
        }),
        ["<S-Tab>"] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else                                                        -- Do whatever
                    fallback()
                end
            end,
            s = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else                                                        -- Do whatever
                    fallback()
                end
            end,
            c = function()
                if cmp.visible() then                     -- If menu is open, navigate next
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else                                                        -- Open completion
                    cmp.complete()
                end
            end,
        }),
        ['<CR>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    if cmp.get_selected_entry() then
                        cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})
                    else
                        cmp.close()
                        fallback()
                    end
                else
                    fallback()
                end
            end,
            c = function(fallback)
                if (cmp.visible() and cmp.get_selected_entry()) then
                    cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})
                else
                    fallback()
                end
            end,
        }),
        -- If arrow keys are invoked; do change the text
        ['<Down>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
        }),
        ['<Up>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    fallback()
                end
            end,
        }),
        -- With escape; pass through if nothing has been selected yet
        ['<Esc>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    if cmp.get_active_entry() then
                        cmp.close()
                    else
                        cmp.close()
                        fallback()
                    end
                else
                    fallback()
                end
            end,
            c = function(fallback)
                if cmp.visible() then
                    if cmp.get_active_entry() then
                        cmp.abort()
                        fallback()
                    else
                        cmp.abort()
                    end
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
})

-- Command line completion
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        {name = 'cmdline'}
    }, {
        {name = 'path'}
    })
})
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' }
    }, {
        { name = 'buffer' }
    })
})

return M
