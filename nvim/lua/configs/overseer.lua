local M = {}

M.setup = function()
  vim.g.overseer_started = true
	require("overseer").setup({
		strategy = {
			"terminal",
			use_shell = true,
		},
		form = {
			border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
		},
		task_list = { direction = "right" },
		templates = { "builtin" },
		component_aliases = {
			default = {
				{ "display_duration", detail_level = 2 },
				"on_output_summarize",
				"on_exit_set_status",
				{ "on_complete_notify", system = "unfocused" },
				"on_complete_dispose",
			},
			default_neotest = {
				"unique",
				{ "on_complete_notify", system = "unfocused", on_change = true },
				"default",
			},
		},
	})
end

return M
