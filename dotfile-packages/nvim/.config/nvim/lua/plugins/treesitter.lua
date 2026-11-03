spec = {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		local languages = {
			"bash",
			"css",
			"dockerfile",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"latex",
			"typst",
			"php",
			"python",
			"scss",
			"sql",
			"typescript",
			"vim",
			"vue",
			"yaml",
			"cpp",
		}

		ts.setup({})

		-- NOTE: If languages fail to install or compilation hangs,
		-- ensure 'tree-sitter-cli' is installed (e.g., :MasonInstall tree-sitter-cli).
		-- If the issue persists, run :checkhealth nvim-treesitter to diagnose.

		-- Use :TSInstall for manuall install languages
		ts.install(languages)

		-- Treesitter features for installed languages must be enabled manually
		vim.api.nvim_create_autocmd("FileType", {
			pattern = vim.list_extend({ "sh", "typescriptreact", "javascriptreact" }, vim.deepcopy(languages)),
			callback = function()
				-- Enable native Neovim treesitter highlighting
				vim.treesitter.start()

				-- Configure code folding
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo.foldmethod = "expr"
				vim.wo.foldlevel = 99

				-- Enable treesitter-based indentation
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}

return spec
