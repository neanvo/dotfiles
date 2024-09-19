local M = {}

M.setup = function()
  require("trouble").setup {
    auto_fold = true,
    fold_open = " ",
    fold_closed = " ",
    height = 16,
    indent_str = " ┊   ",
    include_declaration = {
      "lsp_references",
      "lsp_implementations",
      "lsp_definitions",
    },
    mode = "workspace_diagnostics",
    multiline = true,
    padding = false,
    position = "bottom",
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    signs = require("configs.utils.icons").diagnostics,
    use_diagnostic_signs = true,
    keys = {
      zv = "fold_open",
      zV = "fold_open_recursive",
    }
  }
end

return M
