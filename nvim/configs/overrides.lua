local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "javascript",
    "json",
    "toml",
    "markdown",
    "markdown_inline",
    "bash",
    "lua",
    "tsx",
    "typescript",
    "regex",
    "rust",
    "gitcommit",
    "gitattributes",
    "gitignore",
    "git_rebase",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "gpg",
    "graphql",
    "solidity",
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    "impl",
    "solhint",
    "lua-language-server",
    "nomicfoundation-solidity-language-server",
    -- "rust-analyzer",
    "typescript-language-server",
    "delve",
    "prettier",
    -- golang
    "gopls",
    "golines",
    "golangci-lint",
    "gomodifytags",
    "revive",
  },
}

M.nvimtree = {
  actions = {
    use_system_clipboard = true,
    change_dir = { enable = true, global = true },
  },
  filesystem_watchers = {
    enable = true,
  },
  filters = {
    dotfiles = false,
    custom = {
      "**/node_modules",
      "**/%.git",
      "**/%.github",
    },
  },
  view = {
    adaptive_size = true,
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
      glyphs = {
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
        },
      },
    },
  },
}

return M
