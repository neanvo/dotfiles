local overrides = require "custom.configs.overrides"

-- MISSING: neotest
-- ADJUST: treesitter -- find better highlightings;
-- nvim-tree -- found fancy appereance for leftside pane;
-- null-ls -- switch to nil-ls or adjust config for go;
-- diff-view -- check TODO note
-- neogen -- adjust for Go
-- neotest, dap, dap-ui
local M = {

  -- disabling
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  -- disabling

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
    end,
  },

  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "haydenmeade/neotest-jest",
      "rouge8/neotest-rust",
      "nvim-neotest/neotest-go",
      "nvim-neotest/neotest-plenary",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup {
        adapters = {
          require "neotest-jest" {
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
          require "neotest-rust" {
            args = { "--no-capture" },
            -- dap_adapter = "lldb"
          },
          require "neotest-go" {
            experimental = {
              test_table = true,
            },
            args = { "-count=1", "-timeout=60s" },
          },
          require "neotest-plenary",
        },
      }
    end,
    keys = {
      { "<leader>djw", ":lua require'neotest'.run.run({jestCommand = 'jest --watch '})<cr>", {} },
      { "<leader>dtt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "test" },
      { "<leader>dth", ":lua require'neotest'.run.run()<cr>", desc = "test on hover" },
      { "<leader>dtss", ":lua require'neotest'.run.stop()<cr>", desc = "stop test" },
      { "<leader>dta", ":lua require'neotest'.run.attach()<cr>", desc = "attach test" },
      { "<leader>dtf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
      { "<leader>dtd", ":lua require'neotest'.run.run(vim.fn.getcwd())<cr>", desc = "test directory" },
      { "<leader>dts", ":lua require'neotest'.summary.toggle()<cr>", desc = "test summary" },
      { "<leader>dto", ":lua require'neotest'.output_panel.toggle()<cr>", desc = "test output" },
    },
  },

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = {
      "DapToggleBreakpoint",
      "DapClearBreakpoints",
      "DapListBreakpoints",
      "DapContinue",
      "DapTest",
      "DapClass",
      "DapVisualSelection",
      "DapGoToCursor",
      "DapGoToLine",
      "DapPauseThread",
      "DapToggleRepl",
      "DapStepOver",
      "DapDown",
      "DapStepInto",
      "DapUp",
      "DapTerminate",
    },
    config = require "custom.configs.dap",
    dependencies = {
      require "custom.configs.dap.dapui",
      {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
          require("telescope").load_extension "dap"
        end,
        keys = {
          { "<leader>dtcc", ": Telescope dap commands<cr>", desc = "commands" },
          { "<leader>dtcf", ": Telescope dap configurations<cr>", desc = "configs" },
          { "<leader>dtl", ": Telescope dap list_breakpoints<cr>", desc = "list breakpoints" },
          { "<leader>dtv", ": Telescope dap variables<cr>", desc = "variables" },
          { "<leader>dtf", ": Telescope dap frames<cr>", desc = "frames" },
        },
      },
      { "nvim-neotest/nvim-nio" },
    },
    keys = {
      { "<leader>ds", ": lua require'dap'.toggle_breakpoint()<cr>", desc = "debug breakpoint" },
      { "<leader>dc", ": lua require'dap'.continue()<cr>", desc = "debug continue" },
      { "<leader>dn", ": lua require'dap'.step_over()<cr>", desc = "debug over" },
      { "<leader>di", ": lua require'dap'.step_into()<cr>", desc = "debug into" },
      { "<leader>do", ": lua require'dap'.step_out()<cr>", desc = "debug out" },
      { "<leader>dx", ": lua require'dap'.terminate()<cr>", desc = "terminate" },
      { "<leader>dr", ": lua require'dap'.repl.open()<cr>", desc = "repl" },
      { "<leader>due", ": lua require'dapui'.eval()<cr>", desc = "eval" },
      { "<leader>dus", ": lua require'dapui'.scopes()<cr>", desc = "show scopes" },
      { "<leader>duv", ": lua require'dapui'.variables()<cr>", desc = "variables" },
      { "<leader>duw", ": lua require'dapui'.watches()<cr>", desc = "watches" },
      { "<leader>dd", ": lua require'dapui'.toggle()<cr>", desc = "debug ui toggle" },
      -- { "<leader>dl", ": lua require'dap'.list_breakpoints()<cr>", desc = "list breakpoints" },
    },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local opts = require "custom.configs.null-ls"
      require("null-ls").setup(opts)
    end,
  },

  {
    "ray-x/lsp_signature.nvim",
    opts = function()
      return require "custom.configs.lsp-signature"
    end,
    config = function(opts)
      require("lsp_signature").setup(opts)
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "jose-elias-alvarez/null-ls.nvim", "williamboman/mason.nvim" },
    cmd = { "LspInstall", "LspUninstall" },
    config = function()
      require("mason-lspconfig").setup {}
      -- automatic_installation is handled by lsp-manager
      local settings = require "mason-lspconfig.settings"
      settings.current.automatic_installation = false
    end,
    event = "User FileOpened",
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      "ray-x/lsp_signature.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension "ui-select"
    end,
  },

  -- TODO: add fancy overall view and (idk about that) look for an "diff a file" option
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = function()
      return require "custom.configs.diffview"
    end,
  },

  {
    "FabijanZulj/blame.nvim",
    cmd = "ToggleBlame",
    opts = {
      date_format = "%Y-%m-%d %H:%M",
      merge_consecutive = true,
    },
  },

  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    init = function()
      vim.g.git_messenger_include_diff = "current"
      vim.g.git_messenger_no_default_mappings = true
      vim.g.git_messenger_floating_win_opts = { border = "rounded" }
    end,
  },

  {
    "ruifm/gitlinker.nvim",
    opts = {
      mappings = nil,
      opts = {
        action_callback = function(...)
          return require("gitlinker.actions").open_in_browser(...)
        end,
        print_url = false,
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    opts = function()
      local old = require("plugins.configs.others").gitsigns
      local upd = require "custom.configs.gitsigns"
      return vim.tbl_deep_extend("force", old, upd)
    end,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "git")
      require("gitsigns").setup(opts)
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension "lazygit"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      { "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },
      "andersevenrud/cmp-tmux",
      --
      -- Optional:
      -- vuki656/package-info.nvim // shows versions for NPM
      -- David-Kunz/cmp-npm        // assist with adding NPM packages
    },
    opts = function()
      return require "custom.configs.nvim-cmp"
    end,
  },

  {
    "danymat/neogen",
    event = "VeryLazy",
    opts = { snippet_engine = "luasnip" },
  },

  -- mini.nvim --
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
      require("mini.ai").setup {}

      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
      require("mini.align").setup {
        mappings = {
          start = "<leader>ma",
          start_with_preview = "<leader>mA",
        },
      }

      -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
      require("mini.move").setup {
        mappings = {
          line_left = "M-<",
          line_right = "M->",
        },
      }
    end,
  },

  -- Quality of life section
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
  },

  {
    "kevinhwang91/nvim-hlslens",
    event = "BufReadPost",
    dependencies = { "petertriho/nvim-scrollbar" },
    config = function()
      require("custom.configs.quality.hlslens").config()
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = function()
      local opts = require "custom.configs.quality.scrollbar"
      require("scrollbar").setup(opts)
    end,
  },

  {
    "ggandor/leap.nvim",
    keys = {
      { "ss", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "sS", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "SS", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  -- TODO (postponed): add https://github.com/romgrk/barbar.nvim

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
      require("custom.configs.notify").config()
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("custom.configs.noice").config()
    end,
  },

  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        auto_fold = false,
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
        signs = require("custom.configs.utils").icons.diagnostics,
        use_diagnostic_signs = true,
      }
    end,
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
      { "<leader>lr", "<cmd>TroubleToggle lsp_references<cr>" },
    },
  },

  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    -- config = function()
    --   -- require("custom.configs.bqf").config()
    -- end,
  },

  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("custom.configs.ufo").config()
    end,
  },

  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      local opts = require "custom.configs.gpt"
      require("chatgpt").setup(opts)
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      require("custom.configs.db.dabdob-ui").init()
    end,
  },

  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    config = function()
      require("custom.configs.db.dadbod").setup()
    end,
  },

  -- TODO: https://github.com/kkharji/lspsaga.nvim
  -- TODO: rust
  -- {
  --   "rust-lang/rust.vim",
  --   ft = "rust",
  --   init = function()
  --     vim.g.rustfmt_autosave = 1
  --   end,
  -- },
  --
  -- {
  --   "simrat39/rust-tools.nvim",
  --   lazy = true,
  --   dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
  --   ft = "rust",
  --   config = require "custom.configs.dev.rust-tools",
  -- },

  -- {
  --   "Saecki/crates.nvim",
  --   ft = { "rust", "toml" },
  --   dependencies = {
  --     {
  --       "hrsh7th/nvim-cmp",
  --       opts = function()
  --         local M = require "plugins.configs.cmp"
  --         table.insert(M.sources, { name = "crates" })
  --         return M
  --       end,
  --     },
  --   },
  --   init = function()
  --     vim.api.nvim_create_autocmd("BufRead", {
  --       group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  --       pattern = "Cargo.toml",
  --       callback = function()
  --         require("cmp").setup.buffer { sources = { { name = "crates" } } }
  --         require "crates"
  --       end,
  --     })
  --   end,
  --   opts = {
  --     null_ls = {
  --       enabled = true,
  --       name = "crates.nvim",
  --     },
  --   },
  -- },
}

return M
