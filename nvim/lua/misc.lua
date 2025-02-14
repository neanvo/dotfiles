local M = {}

M.is_wsl = function()
	if os.getenv("WSL_DISTRO_NAME") then
		return true
	end

	local file = io.open("/proc/version", "r")
	if file then
		local content = file:read("*a"):lower()
		file:close()
		return content:find("microsoft") ~= nil or content:find("wsl") ~= nil
	end

	return false
end

return M
