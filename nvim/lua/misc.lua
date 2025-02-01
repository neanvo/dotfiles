local M = {}

M.is_wsl = function ()
  if os.getenv("WSL_DISTRO_NAME") then
    return true
  end
  return false
end


return M
