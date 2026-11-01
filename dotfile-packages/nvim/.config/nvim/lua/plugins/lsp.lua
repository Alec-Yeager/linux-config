return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		{ "neovim/nvim-lspconfig" },
	},
	opts = {
		ensure_installed = { "lua_ls", "clangd", "rust_analyzer", "ruff", "basedpyright" },
	},
	config = function(_, opts)
		require("config.mujin").setup()
		require("mason-lspconfig").setup(opts)
		vim.lsp.inlay_hint.enable(false)
	end,
}
