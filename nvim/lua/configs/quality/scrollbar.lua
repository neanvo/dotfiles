local theme = require("configs.theme").theme

return {
  show_in_active_only = false,
  max_lines = false,
  excluded_filetypes = {
    "TelescopeResults",
    "terminal",
    "NvimTree",
    "nofile",
    -- additional
    -- "query",
    -- "tsplayground",
    -- "lazy",
    -- "lsp-installer",
    -- "markdown",
    -- "mason",
    -- "txt",
    -- "dashboard",
    -- "alpha",
    -- "undotree",
    -- "diff",
    -- "fugitive",
    -- "fugitiveblame",
    -- "Outline",
    -- "SidebarNvim",
    -- "packer",
    -- "lsp-installer",
    -- "TelescopePrompt",
    -- "help",
    -- "telescope",
    -- "lspinfo",
    -- "Trouble",
    -- "null-ls-info",
    -- "quickfix",
    -- "chadtree",
    -- "fzf",
    -- "NeogitStatus",
    -- "terminal",
    -- "console",
    -- "term://*",
    -- "Term://*",
    -- "toggleterm",
    -- "qf",
    -- "prompt",
    -- "noice",
  },
  handle = {
    text = " ",
    hide_if_all_visible = true, -- Hides handle if all lines are visible
  },
  handlers = {
    cursor = false,
    diagnostic = true,
    gitsigns = true,
    search = true, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
  },
  marks = {
    Search = {
      text = { "─", "═" },
      color = theme.yellow,
    },
    Error = {
      text = { "─", "═" },
    },
    Warn = {
      text = { "─", "═" },
      color = theme.orange,
    },
    Info = {
      text = { "─", "═" },
      color = theme.green,
    },
    Hint = {
      text = { "─", "═" },
      color = theme.green,
    },
    Misc = {
      text = { "─", "═" },
      color = theme.orange,
    },
    GitAdd = {
      text = "▕",
      color = theme.green,
    },
    GitChange = {
      text = "▕",
      color = theme.blue,
    },
    GitDelete = {
      text = "▁",
      color = theme.red,
    },
  },
}
