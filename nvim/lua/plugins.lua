local M = {
	"nvim-lua/plenary.nvim",

	{
		"nvim-tree/nvim-web-devicons",
		config = function(_, opts)
			require("nvim-web-devicons").setup(opts)
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, { names = false })
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({ options = { theme = "palenight" } })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = function()
			return require("configs.mason")
		end,
		config = function(_, opts)
			require("mason").setup(opts)

			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-media-files.nvim",
		},
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("configs.nvimtree")
		end,
		config = function(_, opts)
			require("nvim-tree").setup(opts)
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		disable_filetype = { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
				{ path = "lazy.nvim", words = { "Lazy" } },
				{ path = "nvim-dap-ui", words = { "dapui", "require%('dapui'%)" } },
			},
		},
	},

	{
		"stevearc/overseer.nvim",
		dependencies = {
			{
				"stevearc/dressing.nvim",
				opts = {},
			},
		},
		config = function()
			require("configs.overseer").setup()
		end,
		cmd = {
			"OverseerRun",
			"OverseerToggle",
			"OverseerRunCmd",
		},
	},

	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-neotest/nvim-nio",

			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-jest",
			"rouge8/neotest-rust",
			{
				"TheSnakeWitcher/hardhat.nvim",
			},
			"nvim-neotest/neotest-plenary",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("telescope").load_extension("hardhat")
			require("configs.neotest").setup()
		end,
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
		config = require("configs.dap"),
		dependencies = {
			require("configs.dap.dapui"),
			{
				"nvim-telescope/telescope-dap.nvim",
				config = function()
					require("telescope").load_extension("dap")
				end,
			},
			{ "nvim-neotest/nvim-nio" },
		},
	},

	{
		"nvimtools/none-ls.nvim",
		config = function()
			local opts = require("configs.null-ls")
			require("null-ls").setup(opts)
		end,
	},

	{
		"ray-x/lsp_signature.nvim",
		opts = function()
			return require("configs.lsp-signature")
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
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
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
			require("configs.lspconfig")
		end,
	},

	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
		opts = function()
			return require("configs.diffview")
		end,
	},

	{
		"FabijanZulj/blame.nvim",
		cmd = "ToggleBlame",
		commit = "290efdb",
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
			return require("configs.gitsigns")
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			{ "saadparwaiz1/cmp_luasnip", dependencies = "L3MON4D3/LuaSnip" },
			"andersevenrud/cmp-tmux",
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},
		},
		config = function()
			local opts = require("configs.cmp")
			require("cmp").setup(opts)
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},

	{
		"danymat/neogen",
		event = "VeryLazy",
		opts = { snippet_engine = "luasnip" },
	},

	{
		"echasnovski/mini.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
			require("mini.ai").setup({})

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
			require("mini.align").setup({
				mappings = {
					start = "<leader>ma",
					start_with_preview = "<leader>mA",
				},
			})

			-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
			require("mini.move").setup({
				mappings = {
					line_left = "M-<",
					line_right = "M->",
				},
			})
		end,
	},

	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
	},

	{
		"kevinhwang91/nvim-hlslens",
		event = "BufReadPost",
		dependencies = { "petertriho/nvim-scrollbar" },
		config = function()
			require("configs.quality.hlslens").config()
		end,
	},

	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		config = function()
			local opts = require("configs.quality.scrollbar")
			require("scrollbar").setup(opts)
		end,
	},

	{
		"ggandor/leap.nvim",
		keys = {
			{ "ss", "<Plug>(leap-forward-to)", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "sS", "<Plug>(leap-backward-to)", mode = { "n", "x", "o" }, desc = "Leap backward to" },
			{ "L", "<Plug>(leap-from-window)", mode = { "n", "x", "o" }, desc = "Leap from windows" },
		},
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
			require("configs.notify").config()
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
			require("configs.noice").config()
		end,
	},

	{
		"folke/trouble.nvim",
		config = function()
			require("configs.trouble").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = require("configs.todos").opts,
		config = function()
			require("todo-comments").setup({})
		end,
	},

	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			require("rainbow-delimiters.setup").setup({})
		end,
	},

	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
	},

	{
		"kevinhwang91/nvim-ufo",
		event = "VeryLazy",
		dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("configs.ufo").config()
		end,
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
			require("configs.db.dabdob-ui").init()
		end,
	},

	{
		"tpope/vim-dadbod",
		dependencies = {
			"kristijanhusak/vim-dadbod-ui",
			"kristijanhusak/vim-dadbod-completion",
		},
		config = function()
			require("configs.db.dadbod").setup()
		end,
	},

	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup()
		end,
	},

	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		version = "^5",
		lazy = false,
	},

	{
		"Saecki/crates.nvim",
		ft = { "rust", "toml" },
		dependencies = "hrsh7th/nvim-cmp",
		init = function()
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					require("cmp").setup.buffer({ sources = { { name = "crates" } } })
					require("crates")
				end,
			})
		end,
		opts = {
			null_ls = {
				enabled = true,
				name = "crates.nvim",
			},
		},
	},

	{
		"JoosepAlviste/palenightfall.nvim",
		branch = "main",
		config = function()
			require("configs.theme").setup()
		end,
	},

	{
		"nanozuki/tabby.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("configs.tabby").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		dependencies = "JoosepAlviste/palenightfall.nvim",
		config = function()
			require("configs.quality.indent").setup()
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "vimwiki", "telekasten" },
			})
		end,
	},

	{
		"renerocksai/telekasten.nvim",
		dependencies = {
			"renerocksai/calendar-vim",
		},
		cmd = { "Telekasten" },
		config = function()
			require("configs.telekasten")
		end,
	},

	-- Only load whichkey after all the gui
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		config = function(_, opts)
			require("which-key").setup(opts)
		end,
	},
}

return M
