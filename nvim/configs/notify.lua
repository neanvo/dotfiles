local M = {}

M.config = function()
  local status_ok, notify = pcall(require, "notify")
  if not status_ok then
    return
  end
  local opts = {
    timeout = 1000000,
    icons = {
      ERROR = "",
      INFO = "",
      TRACE = "✎",
      WARN = "",
    },
    -- {on_open} `(function)` Function called when a new window is opened, use for changing win settings/config
    -- {on_close} `(function)` Function called when a window is closed
  }
  vim.keymap.set("n", "<ESC>", function()
    require("notify").dismiss()
    vim.cmd.nohl()
  end, {})
  notify.setup(opts)
end

return M
