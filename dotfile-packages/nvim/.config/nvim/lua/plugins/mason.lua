return {
	"mason-org/mason.nvim",
	lazy = false,
	opts = {
		ensure_installed = {
			"tree-sitter-cli",
			"clangd",
			"ruff",
			"lua_ls",
		},
	},
}
