local dap = require("dap")

local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
local liblldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/lldb/lib/liblldb.so" -- Use .dylib for macOS

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = codelldb_path,
		args = { "--port", "${port}" },
		-- For macOS/Linux
		detached = true,
	},
}

dap.configurations.rust = {
	{
		name = "Launch Tauri App",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/src-tauri/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
}

dap.configurations.c = dap.configurations.cpp
