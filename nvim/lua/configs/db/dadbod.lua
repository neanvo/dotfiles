local M = {}

local function db_completion()
	require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
end

-- Read db connections from a YAML file with entries like `<db_name>: <uri>`
local function read_dadbod_conns(f)
	local conn_file = vim.fn.expand(f)
	if vim.fn.filereadable(conn_file) == 0 then
		return {}
	end

	local dbs = {}
	for _, i in pairs(vim.fn.readfile(conn_file)) do
		if not string.match(i, "^#") then -- ignore commented lines
			if string.match(i, ":%s") then
				local conn = vim.fn.split(i, ":\\s")
				dbs = vim.tbl_extend("keep", dbs, { [conn[1]] = conn[2] })
			end
		end
	end
	return dbs
end
vim.g.dbs = read_dadbod_conns("~/.config/nvim/lua/static/dadbod-conns.yaml")

M.setup = function()
	vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"sql",
			"mysql",
			"plsql",
		},
		callback = function()
			vim.schedule(db_completion)
		end,
	})
end

return M
