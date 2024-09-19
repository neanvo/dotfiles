local autocmd = vim.api.nvim_create_autocmd

-- adapted from https://github.com/ethanholz/nvim-lastplace/blob/main/lua/nvim-lastplace/init.lua
local ignore_buftype = { "quickfix", "nofile", "help" }
local ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" }

local function lastplace_handler()
  if vim.tbl_contains(ignore_buftype, vim.bo.buftype) then
    return
  end

  if vim.tbl_contains(ignore_filetype, vim.bo.filetype) then
    -- reset cursor to first line
    vim.cmd[[normal! gg]]
    return
  end

  -- If a line has already been specified on the command line, we are done
  --   nvim file +num
  if vim.fn.line(".") > 1 then
    return
  end

  local last_line = vim.fn.line([['"]])
  local buff_last_line = vim.fn.line("$")

  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    local win_last_line = vim.fn.line("w$")
    local win_first_line = vim.fn.line("w0")
    -- Check if the last line of the buffer is the same as the win
    if win_last_line == buff_last_line then
      -- Set line to last line edited
      vim.cmd[[normal! g`"]]
      -- Try to center
    elseif buff_last_line - last_line > ((win_last_line - win_first_line) / 2) - 1 then
      vim.cmd[[normal! g`"zz]]
    else
      vim.cmd[[normal! G'"<c-e>]]
    end
  end
end

autocmd({'BufWinEnter', 'FileType'}, {
  group    = vim.api.nvim_create_augroup('nvim-lastplace', {}),
  callback = lastplace_handler
})

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append "<>[]hl"

---- options ----
vim.opt.laststatus = 3             -- global statusline
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"  -- Use the system clipboard
vim.opt.shortmess:append "sI"      -- disable nvim intro
vim.opt.expandtab = true         -- Convert tabs to spaces
vim.opt.shiftwidth = 2           -- Indentation level (number of spaces)
vim.opt.smartindent = false       -- Auto-indent based on syntax
vim.opt.fillchars = { eob = " " }   -- Use a space character to fill the end-of-buffer area
vim.opt.ignorecase = true           -- Make searches case-insensitive
vim.opt.tabstop = 2              -- Number of spaces a tab character represents
vim.opt.smartcase = true            -- Make searches case-sensitive if the pattern contains uppercase letters
vim.opt.softtabstop = 2          -- Number of spaces a tab character represents while editing
vim.opt.mouse = "a"                 -- Enable mouse support in all modes
vim.opt.number = true            -- Display line numbers on the left side of the editor
vim.opt.numberwidth = 2          -- Set the width of the line number column to 2 characters
vim.opt.ruler = false            -- Disable the ruler display in the command line area
vim.opt.signcolumn = "yes"         -- Always show the sign column
vim.opt.splitbelow = true         -- Open horizontal splits below the current window
vim.opt.splitright = true         -- Open vertical splits to the right of the current window
vim.opt.termguicolors = true      -- Enable true color support
vim.opt.timeoutlen = 400          -- Set the timeout for key sequences to 400 milliseconds
vim.opt.undofile = true           -- Enable persistent undo files
vim.opt.updatetime = 250          -- Update swap file and related features every 250 milliseconds

vim.opt.hlsearch = true            -- Highlight search matches
vim.opt.incsearch = true           -- Show search matches as you type
vim.opt.cursorline = true          -- Highlight the screen line of the cursor
vim.opt.wrap = false               -- Disable line wrapping
vim.opt.scrolloff = 8              -- Minimum number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8          -- Minimum number of screen columns to keep to the left and right of the cursor
vim.opt.backup = false             -- Disable backup files
vim.opt.writebackup = false        -- Disable backup before overwriting a file
vim.opt.swapfile = false           -- Disable swap file
vim.opt.completeopt = "menuone,noselect" -- Better completion experience
vim.o.showtabline = 2
vim.opt.sessionoptions = 'curdir,folds,globals,help,tabpages,terminal,winsize'
vim.g.mapleader = " "
