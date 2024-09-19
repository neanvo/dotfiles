local M = {}

M = {

	i = {
		["jk"] = { "<Esc>" },

		-- navigate within insert mode
		["<C-h>"] = { "<Left>", "Move left" },
		["<C-l>"] = { "<Right>", "Move right" },
		["<C-j>"] = { "<Down>", "Move down" },
		["<C-k>"] = { "<Up>", "Move up" },

		["<C-b>"] = { "<C-o>b", "Move backward by word" },
		["<C-w>"] = { "<C-o>w", "Move forward to the beginning of the next word" },
		["<C-e>"] = { "<C-o>e", "Move forward to the end of the word" },
	},
	t = {
		["<C-h>"] = { "<C-w>h", "window left" },
		["<C-l>"] = { "<C-w>l", "window right" },
		["<C-j>"] = { "<C-w>j", "window down" },
		["<C-k>"] = { "<C-w>k", "window up" },
		["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
	},
	n = {
		["<Esc>"] = {
			function()
				require("notify").dismiss()
				vim.cmd.nohl()
			end,
			"Esc actions",
		},
		-- switch between windows
		["<C-h>"] = { "<C-w>h", "Window left" },
		["<C-l>"] = { "<C-w>l", "Window right" },
		["<C-j>"] = { "<C-w>j", "Window down" },
		["<C-k>"] = { "<C-w>k", "Window up" },
		-- save
		["<C-s>"] = { "<cmd> w <CR>", "Save file" },
		-- Copy all
		["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },
		-- line numbers
		["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
		["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
		-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
		-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
		-- empty mode is same as using <cmd> :map
		-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
		["<leader>fm"] = {
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"LSP formatting",
		},
		["<tab>"] = { ":tabnext<CR>", "Goto next buffer", opts = { silent = true } },
		["<S-tab>"] = { ":tabprevious<CR>", "Goto prev buffer", opts = { silent = true } },
		["<leader>x"] = { ":tabclose<CR>", "Close buffer" },
		["gn"] = {
			function()
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
			end,
			"git jump to next hunk",
		},
		["gp"] = {
			function()
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
			end,
			"git jump to previous hunk",
		},

		["gr"] = {
			function()
				vim.schedule(function()
					require("gitsigns").reset_hunk()
				end)
			end,
			"git (r)eset hunk",
		},

		["gv"] = {
			function()
				vim.schedule(function()
					require("gitsigns").preview_hunk()
				end)
			end,
			"git pre(v)iew hunk",
		},

		["gs"] = {
			function()
				vim.schedule(function()
					require("gitsigns").stage_hunk()
				end)
			end,
			"git stage hunk",
		},

		["gu"] = {
			function()
				vim.schedule(function()
					require("gitsigns").undo_stage_hunk()
				end)
			end,
			"git unstage hunk",
		},

		["<leader>gfs"] = {
			function()
				vim.schedule(function()
					require("gitsigns").stage_buffer()
				end)
			end,
			"git stage buffer",
		},

		["<leader>gfu"] = {
			function()
				vim.schedule(function()
					require("gitsigns").reset_buffer_index()
				end)
			end,
			"git reset buffer",
		},

		["<leader>gtd"] = {
			function()
				vim.schedule(function()
					require("gitsigns").toggle_deleted()
				end)
			end,
			"git toggle deleted",
		},
		["<leader>gdf"] = {
			function()
				vim.schedule(function()
					require("gitsigns").diffthis()
				end)
			end,
			"Diff this",
		},
		["<leader>gdfl"] = {
			function()
				vim.schedule(function()
					require("gitsigns").diffthis("~1")
				end)
			end,
			"Diff this (~)",
		},
		["<leader>df"] = { "<cmd>DiffviewOpen<CR>", "Open Diff View" },
		["<leader>dh"] = { "<cmd>DiffviewFileHistory %<CR>", "File Diff History" },
		["<leader>dha"] = { "<cmd>DiffviewFileHistory<CR>", "All files Diff History" },
		["<leader>dft"] = { "<cmd>DiffviewToggleFiles<CR>", "Toggle Files" },
		["n"] = { "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", "n search" },
		["N"] = { "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", "N search" },
		["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", "* search" },
		["#"] = { "#<Cmd>lua require('hlslens').start()<CR>", "# search" },
		["g*"] = { "g*<Cmd>lua require('hlslens').start()<CR>", "g* search" },
		["g#"] = { "g#<Cmd>lua require('hlslens').start()<CR>", "g# search" },
		["qq"] = { "<cmd>:q<CR>", "fast exit" },
		["<leader>gg"] = { "<cmd>LazyGit<CR>", "LazyGit" },
		["<leader>gb"] = { "<cmd>ToggleBlame window<CR>", "Git blame (window)" },
		["<leader>gm"] = { "<cmd>GitMessenger<CR>", "Git messenger" },
		["<leader>go"] = {
			function()
				require("gitlinker").get_buf_range_url("n")
			end,
			silent = true,
			desc = "Git open in browser",
		},

		["<leader>ng"] = {
			function()
				require("neogen").generate({})
			end,
			desc = "Neogen Comment",
		},
		["zV"] = {
			function()
				vim.o.foldcolumn = "0"
				require("ufo").openAllFolds()
			end,
			desc = "Open all folds",
		},
		["zC"] = {
			function()
				vim.o.foldcolumn = "1"
				require("ufo").closeAllFolds()
			end,
			desc = "Close all folds",
		},
		["grf"] = {
			function()
				vim.lsp.buf.references()
			end,
			"LSP references",
		},

		-- DB explorer
		["<leader>db"] = { "<Cmd>DBUIToggle<CR>", "DB explorer" },
		["<leader>dbt"] = { ":tab DBUI<cr>", "Open Database client" },
		["<leader>dbf"] = { "<cmd>DBUIFindBuffer<cr>", "Find Buffer" },
		["<leader>dbr"] = { "<cmd>DBUIRenameBuffer<cr>", "Rename Buffer" },
		["<leader>dbq"] = { "<cmd>DBUILastQueryInfo<cr>", "Last Query Info" },
		["<leader>wK"] = {
			function()
				vim.cmd("WhichKey")
			end,
			"Which-key all keymaps",
		},
		["<leader>wk"] = {
			function()
				local input = vim.fn.input("WhichKey: ")
				vim.cmd("WhichKey " .. input)
			end,
			"Which-key query lookup",
		},
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"Toggle comment",
		},
		["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
		["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
		-- LSP
		["[d"] = {
			function()
				vim.diagnostic.goto_prev({ float = { border = "rounded" } })
			end,
			"Goto prev",
		},
		["]d"] = {
			function()
				vim.diagnostic.goto_next({ float = { border = "rounded" } })
			end,
			"Goto next",
		},
		["<leader>ls"] = {
			function()
				vim.lsp.buf.signature_help()
			end,
			"LSP signature help",
		},
		-- Telescope
		["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
		["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
		["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
		["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
		["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
		["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
		["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
		["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
		["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },
		["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },
		["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
		["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
		-- Git
		["]c"] = {
			function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
				return "<Ignore>"
			end,
			"Jump to next hunk",
			opts = { expr = true },
		},
		["[c"] = {
			function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
				return "<Ignore>"
			end,
			"Jump to prev hunk",
			opts = { expr = true },
		},
		["<leader>rh"] = {
			function()
				require("gitsigns").reset_hunk()
			end,
			"Reset hunk",
		},
		["<leader>ph"] = {
			function()
				require("gitsigns").preview_hunk()
			end,
			"Preview hunk",
		},
		["<leader>td"] = {
			function()
				require("gitsigns").toggle_deleted()
			end,
			"Toggle deleted",
		},

		["<leader>xs"] = { "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)" },
		["<leader>xx"] = { "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)" },
		["<leader>xq"] = { "<cmd>Trouble qflist toggle<cr>", "Quickfix List (Trouble)" },
		["<leader>xr"] = {
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			"LSP Definitions/References (Trouble)",
		},
		["<leader>xb"] = { "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer Diagnostics (Trouble)" },

		["<leader>tds"] = { "<cmd>TodoTelescope<cr>", "Show TODOs" },
		["<leader>tdt"] = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },

		["<leader>lc"] = { "<cmd>Lspsaga code_action<cr>", "Code action" },
		["<leader>lo"] = { "<cmd>Lspsaga outline<cr>", "Outline" },
		["<leader>lr"] = { "<cmd>Lspsaga rename<cr>", "Rename" },
		["<leader>lra"] = { "<cmd>Lspsaga rename ++project<cr>", "Rename all project" },
		["gi"] = { "<cmd>Lspsaga subtypes<cr>", "Subtypes" },
		["gI"] = { "<cmd>Lspsaga supertypes<cr>", "Super types" },
		["gd"] = { "<cmd>Lspsaga goto_definition<cr>", "Goto definition" },
		["gD"] = { "<cmd>Lspsaga goto_type_definition<cr>", "Goto type definition" },
		["gpd"] = { "<cmd>Lspsaga peek_definition<cr>", "Goto definition" },
		["gpD"] = { "<cmd>Lspsaga peek_type_definition<cr>", "Goto type definition" },
		["<leader>lfn"] = { "<cmd>Lspsaga finder<cr>", "Lsp Finder" },
		["<leader>lf"] = { "<cmd>Lspsaga show_cursor_diagnostics<cr>", "Lsp show cursor diagnostics" },
		["<leader>lfl"] = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Lsp show line diagnostics" },
		["<leader>ln"] = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Lsp prev diagnostic" },
		["<leader>lm"] = { "<cmd>Lspsaga diagnostic_jump_next<cr>", "Lsp next diagnostic" },
		["K"] = { "<cmd>Lspsaga hover_doc<cr>", "LSP hover" },

		["<leader>dtcc"] = { "<cmd>Telescope dap commands<cr>", "DAP commands" },
		["<leader>dtcf"] = { "<cmd>Telescope dap configurations<cr>", "DAP configs" },
		["<leader>dtl"] = { "<cmd>Telescope dap list_breakpoints<cr>", "DAP list breakpoints" },
		["<leader>dtv"] = { "<cmd>Telescope dap variables<cr>", "DAP variables" },
		["<leader>dtf"] = { "<cmd>Telescope dap frames<cr>", "DAP frames" },
		["<leader>ds"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Debug breakpoint" },
		["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Debug continue" },
		["<leader>dn"] = { "<cmd>lua require'dap'.step_over()<cr>", "Debug step over" },
		["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Debug step into" },
		["<leader>do"] = { "<cmd>lua require'dap'.step_out()<cr>", "Debug step out" },
		["<leader>dx"] = { "<cmd>lua require'dap'.terminate()<cr>", "Debug terminate" },
		["<leader>dr"] = { "<cmd>lua require'dap'.repl.open()<cr>", "Debug REPL" },
		["<leader>due"] = { "<cmd>lua require'dapui'.eval()<cr>", "DAP UI eval" },
		["<leader>dus"] = { "<cmd>lua require'dapui'.scopes()<cr>", "DAP UI show scopes" },
		["<leader>duv"] = { "<cmd>lua require'dapui'.variables()<cr>", "DAP UI variables" },
		["<leader>duw"] = { "<cmd>lua require'dapui'.watches()<cr>", "DAP UI watches" },
		["<leader>dd"] = { "<cmd>lua require'dapui'.toggle()<cr>", "Debug UI toggle" },
		["<leader>dl"] = { "<cmd>lua require'dap'.list_breakpoints()<cr>", "List breakpoints" },

		["<leader>djw"] = {
			"<cmd>lua require'neotest'.run.run({jestCommand = 'jest --watch '})<cr>",
			"Run Jest in watch mode",
		},
		["<leader>dtt"] = { "<cmd>lua require'neotest'.run.run({strategy = 'dap'})<cr>", "Run test with DAP" },
		["<leader>dth"] = { "<cmd>lua require'neotest'.run.run()<cr>", "Run test on hover" },
		["<leader>dtss"] = { "<cmd>lua require'neotest'.run.stop()<cr>", "Stop test" },
		["<leader>dta"] = { "<cmd>lua require'neotest'.run.attach()<cr>", "Attach test" },
		["<leader>dtk"] = { "<cmd>lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", "Run test on file" },
		["<leader>dtd"] = { "<cmd>lua require'neotest'.run.run(vim.fn.getcwd())<cr>", "Run test on directory" },
		["<leader>dts"] = { "<cmd>lua require'neotest'.summary.toggle()<cr>", "Toggle test summary" },
		["<leader>dto"] = { "<cmd>lua require'neotest'.output_panel.toggle()<cr>", "Toggle test output" },

		["<leader>or"] = { "<cmd>OverseerRun<cr>", "Overseer run task" },
		["<leader>ot"] = { "<cmd>OverseerToggle<cr>", "Overseer toggle task window" },
	},

	v = {
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["<"] = { "<gv", "Indent line" },
		[">"] = { ">gv", "Indent line" },
		["<leader>go"] = {
			function()
				require("gitlinker").get_buf_range_url("v")
			end,
			desc = "Git open in browser",
		},
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"Toggle comment",
		},
		["<leader>fm"] = {
			function()
				vim.lsp.buf.range_formatting({}, { vim.fn.line("v"), 0 }, { vim.fn.line("."), -1 })
			end,
			"LSP range formatting",
		},
	},
	x = {
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
	},
}

-- Cheat sheet for kylechui/nvim-surround
--     Old text                    Command         New text
-- --------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
return M
