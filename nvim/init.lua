require("autocmd")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local bootstrap = require("bootstrap")

bootstrap.load_mappings()

if not vim.loop.fs_stat(lazypath) then
	bootstrap.lazy(lazypath)
end

-- Ensure that `lazy.nvim` is in the runtime path
vim.opt.rtp:prepend(lazypath)

-- install plugins
local plugins = require("plugins")
require("lazy").setup(plugins)
