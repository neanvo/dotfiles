local M = {}

M.setup = function()
	local theme = {
		fill = "TabLineFill",
		head = "TabLine",
		current_tab = "TabLineSel",
		tab = "TabLine",
		win = "TabLineWin",
	}

	require("tabby.tabline").set(function(line)
		return {
			{
				{ " 👾 ", hl = theme.head },
				line.sep("", theme.head, theme.fill),
			},
			line.tabs().foreach(function(tab)
				local hl = tab.is_current() and theme.current_tab or theme.tab
				return {
					line.sep("", hl, theme.fill),
					tab.name(),
					line.sep("", hl, theme.fill),
					hl = hl,
					margin = " ",
				}
			end),
			line.spacer(),
		}
	end)
end

return M
