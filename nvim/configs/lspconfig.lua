local capabilities = require("plugins.configs.lspconfig").capabilities
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  -- format on save
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = true }
      end,
    })
  end
  require("plugins.configs.lspconfig").on_attach(client, bufnr)
end

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "clangd",
  -- Solidity
  "solidity_ls_nomicfoundation",
  -- languages
  -- "gopls", -- explicitly
  "tsserver",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  experimentalPostfixCompletions = true,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
  settings = {
    gopls = {
      completeUnimported = true,
      experimentalPostfixCompletions = true,
      usePlaceholders = true,
      staticcheck = true,
      analyses = {
        fieldalignment = true,
        unusedwrite = true,
        useany = true,
        unusedparams = true,
        unusedvariable = true,
      },
    },
  },
}

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

-- configs.solidity = {
--   default_config = {
--     cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
--     filetypes = { "solidity" },
--     root_dir = lspconfig.util.find_git_ancestor,
--     single_file_support = true,
--   },
-- }
