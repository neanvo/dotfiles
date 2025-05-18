local dap = require("dap")
dap.set_log_level("TRACE")  -- Options: TRACE, DEBUG, INFO, WARN, ERROR

dap.adapters.go = function(callback)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local port = 38697
	local opts = {
		stdio = { nil, stdout },
		args = { "dap", "-l", "127.0.0.1:" .. port },
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			vim.notify(
				string.format('"dlv" exited with code: %d, please check your configs for correctness.', code),
				vim.log.levels.WARN,
				{ title = "[go] DAP Warning!" }
			)
		end
	end)
	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	-- Wait for delve to start
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "go",
		name = "Debug project",
		request = "launch",
		program = "${workspaceFolder}/cmd/main/",
		justMyCode = false,
	},	
  {
		type = "go",
		name = "Debug project (+ENVs)",
		request = "launch",
		program = "${workspaceFolder}/cmd/main/",
		justMyCode = false,
		env = function()
			local input = vim.fn.input("Env var(s) (KEY=VAL ...): ")
			local result = {}
			for _, pair in ipairs(vim.fn.split(input, " ", true)) do
				local key, val = string.match(pair, "([^=]+)=?(.*)")
				if key then result[key] = val end
			end
			return result
		end,
	},
	{ type = "go", name = "Debug", request = "launch", program = "${file}" },
	{
		type = "go",
		name = "Debug with args",
		request = "launch",
		program = "${file}",
		args = function()
			local argument_string = vim.fn.input("Program arg(s): ")
			return vim.fn.split(argument_string, " ", true)
		end,
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	}, -- works with go.mod packages and sub packages
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

dap.configurations.typescript = {
  {
    name = "Attach to NodeJS process",
    type = "pwa-node",
    request = "attach",
    processId = require('dap.utils').pick_process,
    cwd = vim.fn.getcwd(),
    restart = false,
    sourceMaps = true,
    port = 9229,
    -- protocol = "inspector",
    -- skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
}
