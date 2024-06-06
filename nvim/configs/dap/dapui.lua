return {
  "rcarriga/nvim-dap-ui",
  lazy = true,
  keys = {
    {
      "<leader>dsc",
      function()
        require("dapui").float_element("scopes", { width = 80, height = 30, enter = true })
      end,
    },
  },
  opts = {
    icons = {
      expanded = "",
      collapsed = "",
      current_frame = "▸",
    },
    layouts = {
      {
        elements = {
          { id = "scopes", size = 0.5 },
          { id = 'breakpoints', size = 0.1 },
          { id = "stacks", size = 0.1 },
          -- 'watches',
          { id = "repl", size = 0.1 },
        },
        size = 45,
        position = "left",
      },
      {
        elements = {
          "console",
        },
        size = 30,
        position = "bottom",
      },
    },
    controls = {
      enabled = true,
    },
    render = {
      max_type_length = nil,
      max_value_lines = nil,
    },
  },
  config = function(_, opts)
    local ns = vim.api.nvim_create_namespace "dap"
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "dap-repl",
        "dapui_scopes",
        "dapui_breakpoints",
        "dapui_stacks",
        "dapui_watches",
      },
      callback = function()
        vim.opt_local.signcolumn = "no"
        vim.api.nvim_win_set_hl_ns(0, ns)
        vim.api.nvim_set_hl(ns, "EndOfBuffer", { fg = "bg", bg = "bg" })
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dap-repl",
      callback = function()
        require("dap.ext.autocompl").attach()
      end,
    })

    require("dapui").setup(opts)

    vim.api.nvim_set_hl(0, "DapUIScope", { bold = true })
    vim.api.nvim_set_hl(0, "DapUIDecoration", { link = "CursorLineNr" })
    vim.api.nvim_set_hl(0, "DapUIThread", { link = "GitSignsAdd" })
    vim.api.nvim_set_hl(0, "DapUIStoppedThread", { link = "Special" })
    vim.api.nvim_set_hl(0, "DapUILineNumber", { link = "Normal" })
    vim.api.nvim_set_hl(0, "DapUIType", { link = "Type" })
    vim.api.nvim_set_hl(0, "DapUISource", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "DapUIWatchesEmpty", { link = "Comment" })
    vim.api.nvim_set_hl(0, "DapUIWatchesValue", { link = "GitSignsAdd" })
    vim.api.nvim_set_hl(0, "DapUIWatchesError", { link = "DiagnosticError" })
  end,
}
