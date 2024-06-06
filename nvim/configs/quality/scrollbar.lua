-- local colors = require("tokyonight.colors").setup()
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
      color = "#C9A554", -- TODO: colors
    },
    Error = {
      text = { "─", "═" },
      -- color = "#R9A554", -- TODO: colors
    },
    Warn = {
      text = { "─", "═" },
      color = "#B36D43", -- TODO: colors
    },
    Info = {
      text = { "─", "═" },
      color = "#5f875f", -- TODO: colors
    },
    Hint = {
      text = { "─", "═" },
      color = "#5f875f", -- TODO: colors
    },
    Misc = {
      text = { "─", "═" },
      color = "#bb7744", -- TODO: colors
    },
    GitAdd = {
      text = "▕",
      color = "#5f875f", -- TODO: colors
    },
    GitChange = {
      text = "▕",
      color = "#C9A554", -- TODO: colors
    },
    GitDelete = {
      text = "▁",
      -- color = "#R9A554", -- TODO: colors
    },
  },
}
