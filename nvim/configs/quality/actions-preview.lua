local opts = {
  diff = {
    algorithm = "patience",
    ignore_whitespace = true,
  },
  telescope = require("telescope.themes").get_dropdown { winblend = 10 },
}

return {
  opts
}
