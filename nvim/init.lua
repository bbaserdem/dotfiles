--[[------------------------------------------------------------------------]]--
--[[--------------------------INIT - init file--------------------------]]--
--[[------------------------------------------------------------------------]]--

vim.api.nvim_command('source $XDG_CONFIG_HOME/nvim/oldinit.vim')

local core_modules = {
  -- Main settings
  'core/options',
  'core/plugins',
  'core/uiprefs',
  'core/fndefns',
  'core/servers',
  'core/keymaps',

  -- Plugin configurations
  'configs/cmpnvim',
  'configs/echodoc',
  'configs/indentblankline',
  'configs/lspkind',
  'configs/marks',
  --'configs/mkdnflow',
  'configs/null_ls',
  'configs/nvim_markdown',
  'configs/nvimtree',
  'configs/scrollbar',
  'configs/texlabconfig',
  'configs/trouble',
  'configs/vimtex',
  'configs/vscode',

  -- LSP configurations
  'servers/sumneko_lua',
  'servers/texlab',
  'servers/ltex',
}

-- Using pcall we can handle better any loading issues
for _, module in ipairs(core_modules) do
    local ok, err = pcall(require, module)
    if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
      return
    end
end
