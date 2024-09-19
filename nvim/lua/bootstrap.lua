local fn = vim.fn
local M = {}

M.echo = function(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

local function shell_call(args)
  local output = fn.system(args)
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

M.lazy = function(install_path)
  --------- lazy.nvim ---------------
  M.echo "  Installing lazy.nvim & plugins ..."
  local repo = "https://github.com/folke/lazy.nvim.git"
  shell_call { "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path }
  vim.opt.rtp:prepend(install_path)
end

M.load_mappings = function()
  vim.schedule(function()
    local function set_section_map(section_values)
      for mode, mode_values in pairs(section_values) do
        for keybind, mapping_info in pairs(mode_values) do
          local opts = mapping_info.opts or {}
          opts.desc = mapping_info[2]
          vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
      end
    end

    local mappings = require("mappings")
    set_section_map(mappings)
  end)
end

return M
