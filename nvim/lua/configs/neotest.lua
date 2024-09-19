local M = {}

local icons = require("configs.utils.icons").neotest

-- get neotest namespace (api call creates or returns namespace)
local neotest_ns = vim.api.nvim_create_namespace("neotest")
vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
			return message
		end,
	},
}, neotest_ns)

M.setup = function()
	require("neotest").setup({
		adapters = {
			-- https://github.com/nvim-neotest/neotest-python
			require("neotest-python")({
				dap = {
					justMyCode = false,
					console = "integratedTerminal",
					stopOnEntry = false, -- which is the default(false)
					subProcess = false,
					openUIOnEntry = false,
				},
				args = { "-vv", "-s" },
				runner = "pytest",
			}),

			-- https://github.com/nvim-neotest/neotest-jest
			-- Monorepos https://github.com/nvim-neotest/neotest-jest?tab=readme-ov-file#monorepos
			require("neotest-jest")({
				jestCommand = "npm test --",
				jestConfigFile = "custom.jest.config.ts",
				env = { CI = true },
				cwd = function(_)
					return vim.fn.getcwd()
				end,
				jest_test_discovery = true,
				discovery = {
					enabled = false,
				},
			}),

			-- https://github.com/rouge8/neotest-rust
			require("neotest-rust")({
				args = { "--no-capture" },
				dap_adapter = "lldb",
			}),

			-- https://github.com/nvim-neotest/neotest-go
			require("neotest-go")({
				experimental = {
					test_table = true,
				},
				args = { "-count=1", "-timeout=60s" },
			}),

			require("neotest-plenary"),

			-- https://github.com/TheSnakeWitcher/hardhat.nvim
			require("neotest-hardhat"),
		},
		floating = {
			max_width = 0.9,
			max_height = 0.8,
			border = "rounded",
			options = {},
		},
		icons = icons,
		quickfix = {
			enabled = true,
			open = false,
		},
	})
end

return M
