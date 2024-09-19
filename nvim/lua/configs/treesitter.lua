local options = {
	ensure_installed = {
		"vim",
		"html",
		"css",
		"javascript",
		"json",
		"toml",
		"markdown",
		"markdown_inline",
		"bash",
		"lua",
		"tsx",
		"typescript",
		"regex",
		"rust",
		"gitcommit",
		"gitattributes",
		"gitignore",
		"git_rebase",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"gpg",
		"graphql",
		"solidity",
	},
	auto_install = true,

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = { enable = true },
}

return options
