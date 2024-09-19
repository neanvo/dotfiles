local M = {}

M.setup = function()
	require("ibl").setup({
		debounce = 100,
		indent = { char = "▏" },
		whitespace = { remove_blankline_trail = true },
		scope = {
			char = "▏",
			show_start = false,
			show_end = false,
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		},
	})
end

return M
