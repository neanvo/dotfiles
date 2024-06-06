local null_ls = require("null-ls")

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

local M = {}

M.sources = {

  -- Grammar

  -- Webdev stuff
  format.deno_fmt, -- fast js/ts formatter
  format.prettier.with { filetypes = { "html", "markdown", "css", "solidity" } },

  -- Lua
  format.stylua,

  -- Shell
  format.shfmt,
  lint.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Rust
  format.rustfmt,

  -- Solidity
  -- solhint = {
  --   sourceName = "solhint",
  --   command = "solhint",
  --   debounce = 100,
  --   args = { "--formatter", "json", "--fix", "--max-warnings", "0", "--", "-" },
  --   format = "json",
  -- },

  -- Go
  format.goimports_reviser,
  format.golines,
  actions.gomodifytags,
  actions.impl,
  -- lint.golangci_lint.with { filetypes = { "go" }, diagnostics_format = "[golint] #{m}(#{c})", args = { "run", "--fix=false", "--concurrency=16",  }, },
  -- lint.revive,
}

M.debug = true

return M
