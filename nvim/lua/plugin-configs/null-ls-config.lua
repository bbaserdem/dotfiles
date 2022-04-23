---------------
--- Null-ls ---
---------------
local plug = require("null-ls")
return plug.setup({
  cmd = { "nvim" },
  debounce = 250,
  debug = false,
  default_timeout = 5000,
  diagnostics_format = "[#{c}] #{m} (#{s})",
  fallback_severity = vim.diagnostic.severity.ERROR,
  log = {
    enable = true,
    level = "warn",
    use_console = "async",
  },
  on_attach = nil,
  on_init = nil,
  on_exit = nil,
  --root_dir = u.root_pattern(".null-ls-root", "Makefile", ".git"),
  sources = {
    plug.builtins.code_actions.gitsigns,
    plug.builtins.code_actions.proselint,
    plug.builtins.code_actions.refactoring,
    plug.builtins.code_actions.shellcheck,
    plug.builtins.completion.spell,
    plug.builtins.diagnostics.checkmake,
    plug.builtins.diagnostics.chktex,
    plug.builtins.diagnostics.codespell,
    plug.builtins.diagnostics.eslint,
    plug.builtins.diagnostics.flake8,
    plug.builtins.diagnostics.gitlint,
    plug.builtins.diagnostics.hadolint,
    plug.builtins.diagnostics.jsonlint,
--    plug.builtins.diagnostics.luacheck,
    plug.builtins.diagnostics.markdownlint,
    plug.builtins.diagnostics.mdl,
    plug.builtins.diagnostics.mlint,
    plug.builtins.diagnostics.proselint,
    plug.builtins.diagnostics.pydocstyle,
    plug.builtins.diagnostics.pylama,
    plug.builtins.diagnostics.pylint,
    plug.builtins.diagnostics.shellcheck,
    plug.builtins.diagnostics.trail_space,
    plug.builtins.diagnostics.vint,
    plug.builtins.diagnostics.write_good,
    plug.builtins.diagnostics.yamllint,
    plug.builtins.diagnostics.zsh,
    plug.builtins.formatting.autopep8,
    plug.builtins.formatting.black,
    plug.builtins.formatting.cmake_format,
    plug.builtins.formatting.codespell,
    plug.builtins.formatting.isort,
    plug.builtins.formatting.jq,
    plug.builtins.formatting.json_tool,
    plug.builtins.formatting.latexindent,
    plug.builtins.formatting.markdownlint,
    plug.builtins.formatting.prettierd,
    plug.builtins.formatting.shellharden,
    plug.builtins.formatting.stylua,
    plug.builtins.formatting.trim_newlines,
    plug.builtins.formatting.trim_whitespace,
    plug.builtins.formatting.xmllint,
    plug.builtins.hover.dictionary,
    },
  update_in_insert = false,
})
