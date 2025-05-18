local misc = require("misc")

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
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
				version = "1.*",
			},
			{
				"mxsdev/nvim-dap-vscode-js",
				config = function()
					require("dap-vscode-js").setup({
						debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
						adapters = { "pwa-node", "chrome", "pwa-chrome" },
					})
				end,
			},
			{ "nvim-neotest/nvim-nio" },
			{
				"jay-babu/mason-nvim-dap.nvim",
				opts = {
					handlers = {
						js = function()
							local dap = require("dap")
							dap.adapters["pwa-node"] = {
								type = "server",
								port = "${port}",
								executable = { command = vim.fn.exepath("js-debug-adapter"), args = { "${port}" } },
							}
							require("dap.ext.vscode").type_to_filetypes["pwa-node"] =
								{ "javascript", "javascriptreact", "typescript", "typescriptreact" }

							local pwa_node_attach = {
								type = "pwa-node",
								request = "launch",
								name = "js-debug: Attach to Process (pwa-node)",
								processId = require("dap.utils").pick_process,
								cwd = "${workspaceFolder}",
							}
							local function deno(cmd)
								cmd = cmd or "run"
								return {
									request = "launch",
									name = ("js-debug: Launch Current File (deno %s)"):format(cmd),
									type = "pwa-node",
									program = "${file}",
									cwd = "${workspaceFolder}",
									runtimeExecutable = vim.fn.exepath("deno"),
									runtimeArgs = { cmd, "--inspect-brk" },
									attachSimplePort = 9229,
								}
							end
							local function typescript(args)
								return {
									type = "pwa-node",
									request = "launch",
									name = ("js-debug: Launch Current File (ts-node%s)"):format(
										args and (" " .. table.concat(args, " ")) or ""
									),
									program = "${file}",
									cwd = "${workspaceFolder}",
									runtimeExecutable = "ts-node",
									runtimeArgs = args,
									sourceMaps = true,
									protocol = "inspector",
									console = "integratedTerminal",
									resolveSourceMapLocations = {
										"${workspaceFolder}/dist/**/*.js",
										"${workspaceFolder}/**",
										"!**/node_modules/**",
									},
								}
							end
							for _, language in ipairs({ "javascript", "javascriptreact" }) do
								dap.configurations[language] = {
									{
										type = "pwa-node",
										request = "launch",
										name = "js-debug: Launch File (pwa-node)",
										program = "${file}",
										cwd = "${workspaceFolder}",
									},
									deno("run"),
									deno("test"),
									pwa_node_attach,
								}
							end
							for _, language in ipairs({ "typescript", "typescriptreact" }) do
								dap.configurations[language] = {
									typescript(),
									typescript({ "--esm" }),
									deno("run"),
									deno("test"),
									pwa_node_attach,
								}
							end
						end,
					},
				},
			},
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
		enabled = not misc.is_wsl(),
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
			require("configs.notify").config()
		end,
	},

	{
		enabled = not misc.is_wsl(),
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
				file_types = { "markdown", "vimwiki", "telekasten", "Avante" },
			})
		end,
		ft = { "markdown", "Avante" },
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

	{
		"neanvo/buben.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("buben").setup({
				popup = {
					width = 60,
				},
				use_default_highlights = false,
			})
		end,
	},
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
		config = function()
			require("mcphub").setup({
				config = vim.fn.expand("~/.config/mcp.json"),
				auto_approve = true,
				extensions = {
					avante = {
						make_slash_commands = true, -- make /slash commands from MCP server prompts
					},
					codecompanion = {
						-- Show the mcp tool result in the chat buffer
						-- NOTE:if the result is markdown with headers, content after the headers wont be sent by codecompanion
						show_result_in_chat = false,
						make_vars = true, -- make chat #variables from MCP server resources
						make_slash_commands = true, -- make /slash commands from MCP server prompts
					},
				},
			})
		end,
	},

	-- TODO: add reasoning and the other (https://github.com/yetone/cosmos-nvim/blob/596bc7b620400f9d23041a9568cd8d74c636fc68/lua/layers/completion/plugins.lua#L202C17-L202C31)
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- auto_suggestions_provider = "claude",
			-- cursor_applying_provider = "claude", -- I'm using Claude Text Editor Tool Mode
			provider = "claude",
			disabled_tools = { "git_commit", "git_diff" },
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-7-sonnet-20250219",
				timeout = 30000, -- Timeout in milliseconds
				-- temperature = 0,
				max_tokens = 20480,
				temperature = 1,
				thinking = {
					type = "enabled",
					budget_tokens = 2000,
				},
				disable_tools = { "python" },
			},
			vendors = {
				["claude-sonnet35"] = {
					__inherited_from = "claude",
					model = "claude-3-5-sonnet-20241022",
					timeout = 30000, -- Timeout in milliseconds
					temperature = 0,
					max_tokens = 8192,
				},
				["claude-sonnet37"] = {
					__inherited_from = "claude",
					model = "claude-3-7-sonnet-20250219",
					timeout = 30000, -- Timeout in milliseconds
					temperature = 0,
					max_tokens = 20480,
				},
				["groq"] = { -- define groq provider
					__inherited_from = "openai",
					api_key_name = "GROQ_API_KEY",
					endpoint = "https://api.groq.com/openai/v1/",
					model = "llama-3.3-70b-versatile",
					max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
				},
			},
			--
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_apply_diff_after_generation = true,
				auto_set_keymaps = true,
				auto_set_highlight_group = true,
				jump_result_buffer_on_finish = true,
				use_cwd_as_project_root = true,
				minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
				enable_token_counting = true, -- Whether to enable token counting. Default to true.
				-- NOTE: works bad
				-- enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
				-- enable_claude_text_editor_tool_mode = true, -- Whether to enable Claude Text Editor Tool Mode.
				--
				-- 		support_paste_from_clipboard = false,
			},
			windows = {
				position = "smart",
				height = 46,
				wrap = true,
				sidebar_header = {
					align = "center",
				},
				ask = {
					floating = false,
				},
			},
			web_search_engine = {
				provider = "brave", -- or "serpapi"
			},
			system_prompt = function()
				local system_prompt = [[
Follow these steps for each interaction:

1. User Identification:
   - You should assume that you are interacting with default_user
   - If you have not identified default_user, proactively try to do so.

2. Memory Retrieval:
   - Always begin your chat by saying only "Remembering..." and retrieve all relevant information from your knowledge graph
   - Always refer to your knowledge graph as your "memory"

3. Memory
   - While conversing with the user, be attentive to any new information that falls into these categories:
     a) Basic Identity (age, gender, location, job title, education level, etc.)
     b) Behaviors (interests, habits, etc.)
     c) Preferences (communication style, preferred language, etc.)
     d) Goals (goals, targets, aspirations, etc.)
     e) Relationships (personal and professional relationships up to 3 degrees of separation)

4. Memory Update:
   - If any new information was gathered during the interaction, update your memory as follows:
     a) Create entities for recurring organizations, people, and significant events
     b) Connect them to the current entities using relations
     b) Store facts about them as observations
        ]]
				local hub = require("mcphub").get_hub_instance()
				return system_prompt .. "\n\n" .. hub:get_active_servers_prompt()
			end,
			custom_tools = function()
				return {
					require("mcphub.extensions.avante").mcp_tool(),
				}
			end,
		},
		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"echasnovski/mini.pick", -- for file_selector provider mini.pick
			"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
			"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
			"ibhagwan/fzf-lua", -- for file_selector provider fzf
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			"MeanderingProgrammer/render-markdown.nvim",
		},
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
