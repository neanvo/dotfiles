local M = {}
local icons = require("configs.utils.icons")

M.setup = function()
  require('lspsaga').setup {
    diagnostic = {
        max_height = 0.8,
        keys = {
            quit = {'q', '<ESC>'}
        }
    },
    finder = {
      keys = {
        vsplit = 'v',
        split = 'h',
        toggle_or_open = '<CR>',
        shuttle = 'W',
        tabnew = 'T',
      },
    },
    ui = {
        code_action = icons.diagnostics.HintWhite
    },
  }
end

return M
