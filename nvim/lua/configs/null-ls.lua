local null_ls = require("null-ls")

local format = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

local M = {}

M.sources = {

	-- Webdev stuff
	lint.semgrep,
	format.deno_fmt, -- fast js/ts formatter
	format.prettier.with({
		extra_filetypes = { "solidity", "toml" },
	}),
	format.prettierd,
	format.biome,

	-- Lua
	format.stylua,

	-- Shell
	format.shfmt,
	lint.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

	-- Solidity
	lint.solhint.with({
		sourceName = "solhint",
		command = "solhint",
		debounce = 100,
		args = { "--formatter", "json", "--fix", "--max-warnings", "0", "--", "-" },
		format = "json",
	}),
	format.forge_fmt,

	-- Go
	lint.staticcheck,
	format.gofumpt,
	format.goimports_reviser,
	format.golines,
	--NOTE: disabled cause of message spamming at bottom right
	-- actions.gomodifytags,
	-- actions.impl,
	lint.golangci_lint,
	lint.revive,

	-- Python
	lint.mypy,
	lint.pylint,
	format.black,
	format.isort,

	-- Make
	lint.checkmake,
	-- lint.cmake_lint, -- incopatible with mason issue

	-- Markdown
	lint.markdownlint,

	-- SQL
	lint.sqlfluff.with({
		extra_args = { "--dialect", "postgres" },
	}),
	format.sqlfluff.with({
		extra_args = { "--dialect", "postgres" },
	}),
	format.sqlfmt,
	format.sql_formatter, -- white-spaces

	----------------------------------------------------------
	-- Format
	format.findent, -- fortran
	format.hclfmt, -- HCL
	format.markdownlint,
	format.terraform_fmt, -- tf
	format.terragrunt_fmt, -- tf
	format.protolint, -- buf
	format.yamlfmt,

	-- Diagnostics
	lint.actionlint,
	lint.ansiblelint,
	lint.buf, -- protobuf
	lint.protolint, -- protobuf
	lint.cfn_lint, -- cloudflare
	lint.hadolint, -- docker
	lint.vacuum, -- json/yaml openapi
	lint.yamllint,
	lint.terraform_validate,
	lint.terragrunt_validate,
	lint.tfsec, -- terraform
	lint.trivy, --terraform
	-- lint.trail_space,
}

M.debug = true

return M
