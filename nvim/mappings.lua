---@type MappingsTable
local M = {}

M.disabled = {

  n = {
    ["gr"] = {},
    ["]c"] = {},
    ["[c"] = {},
    ["<leader>rh"] = {},
    ["<leader>ph"] = {},
  },
}

M.general = {

  i = {
    ["jk"] = { "<Esc>" },
  },

  t = {
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    ["gn"] = {
      function()
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
      end,
      "git jump to next hunk",
    },
    ["gp"] = {
      function()
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
      end,
      "git jump to previous hunk",
    },

    ["gr"] = {
      function()
        vim.schedule(function()
          require("gitsigns").reset_hunk()
        end)
      end,
      "git (r)eset hunk",
    },

    ["gv"] = {
      function()
        vim.schedule(function()
          require("gitsigns").preview_hunk()
        end)
      end,
      "git pre(v)iew hunk",
    },

    ["gs"] = {
      function()
        vim.schedule(function()
          require("gitsigns").stage_hunk()
        end)
      end,
      "git stage hunk",
    },

    ["gu"] = {
      function()
        vim.schedule(function()
          require("gitsigns").undo_stage_hunk()
        end)
      end,
      "git unstage hunk",
    },

    ["<leader>gfs"] = {
      function()
        vim.schedule(function()
          require("gitsigns").stage_buffer()
        end)
      end,
      "git stage buffer",
    },

    ["<leader>gfu"] = {
      function()
        vim.schedule(function()
          require("gitsigns").reset_buffer_index()
        end)
      end,
      "git reset buffer",
    },

    ["<leader>gtd"] = {
      function()
        vim.schedule(function()
          require("gitsigns").toggle_deleted()
        end)
      end,
      "git toggle deleted",
    },
    ["<leader>gdf"] = {
      function()
        vim.schedule(function()
          require("gitsigns").diffthis()
        end)
      end,
      "Diff this",
    },
    ["<leader>gdfl"] = {
      function()
        vim.schedule(function()
          require("gitsigns").diffthis "~1"
        end)
      end,
      "Diff this (~)",
    },
  },
}

M.diffview = {

  n = {
    ["<leader>df"] = { "<cmd>DiffviewOpen<CR>", "Open Diff View" },
    ["<leader>dh"] = { "<cmd>DiffviewFileHistory %<CR>", "File Diff History" },
    ["<leader>dha"] = { "<cmd>DiffviewFileHistory<CR>", "All files Diff History" },
    ["<leader>dft"] = { "<cmd>DiffviewToggleFiles<CR>", "Toggle Files" },
  },

}

M.hlslens = {
  n = {
    ["n"] = { "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", "n search" },
    ["N"] = { "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", "N search" },
    ["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", "* search" },
    ["#"] = { "#<Cmd>lua require('hlslens').start()<CR>", "# search" },
    ["g*"] = { "g*<Cmd>lua require('hlslens').start()<CR>", "g* search" },
    ["g#"] = { "g#<Cmd>lua require('hlslens').start()<CR>", "g# search" },
  },
}

M.common = {

  n = {
    ["<leader>gg"] = { "<cmd>LazyGit<CR>", "LazyGit" },
    ["<leader>gb"] = { "<cmd>ToggleBlame window<CR>", "Git blame (window)" },
    ["<leader>gm"] = { "<cmd>GitMessenger<CR>", "Git messenger" },
    ["<leader>go"] = {
      function()
        require("gitlinker").get_buf_range_url "n"
      end,
      silent = true,
      desc = "Git open in browser",
    },

    ["<leader>ng"] = {
      function()
        require("neogen").generate {}
      end,
      desc = "Neogen Comment",
    },
    ["zV"] = {
      function()
        vim.o.foldcolumn = "0"
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
    ["zC"] = {
      function()
        vim.o.foldcolumn = "1"
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },

    -- DB explorer
    ["<leader>db"] = { "<Cmd>DBUIToggle<CR>", "DB explorer" },
    ["<leader>dbt"] = { ":tab DBUI<cr>", "Open Database client" },
    ["<leader>dbf"] = { "<cmd>DBUIFindBuffer<cr>", "Find Buffer" },
    ["<leader>dbr"] = { "<cmd>DBUIRenameBuffer<cr>", "Rename Buffer" },
    ["<leader>dbq"] = { "<cmd>DBUILastQueryInfo<cr>", "Last Query Info" },
  },

  v = {
    ["<leader>go"] = {
      function()
        require("gitlinker").get_buf_range_url "v"
      end,
      desc = "Git open in browser",
    },
  },
}

-- Cheat sheet for kylechui/nvim-surround
--     Old text                    Command         New text
-- --------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
return M
