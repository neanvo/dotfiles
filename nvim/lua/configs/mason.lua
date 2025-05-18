-- There are some packages that must installed manually:
-- forge (https://github.com/foundry-rs/foundry)
-- terraform
-- terragrunt
-- pg_format https://github.com/darold/pgFormatter
local options = {
	ensure_installed = {
		"lua-language-server",
		"solhint",
		"prettier",
		"prettierd",
		"luacheck",
		"flake8",
		"black",
		"eslint-lsp",
		"eslint_d",
		"fixjson",
		"shellcheck",
		"shfmt",
		"hadolint",
		"cpplint",
		"clang-format",
		"revive",
		"gofumpt",
		"goimports",
		"golines",
		"dprint",
		"semgrep",
		"deno",
		"biome",
		"staticcheck",
		"goimports-reviser",
		"gomodifytags",
		"impl",
		"golangci-lint",
		"mypy",
		"pylint",
		"isort",
		"chechmake",
		"cmakelint",
		"markdownlint",
		"sqlfluff",
		"sqlfmt",
		"sql-formatter",
		"findent",
		"hclfmt",
		"markdownlint",
		"tflint",
		"protolint",
		"yamlfmt",
		"actionlint",
		"ansible-lint",
		"buf",
		"cfn-lint",
		"vacuum",
		"yamllint",
		"tfsec",
		"trivy",
    "codelldb"
	},
	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = "󰄳 ",
			package_uninstalled = " 󰚌",
		},

		keymaps = {
			toggle_server_expand = "<CR>",
			install_server = "i",
			update_server = "u",
			check_server_version = "c",
			update_all_servers = "U",
			check_outdated_servers = "C",
			uninstall_server = "X",
			cancel_installation = "<C-c>",
		},
	},

	max_concurrent_installers = 10,
}

return options
