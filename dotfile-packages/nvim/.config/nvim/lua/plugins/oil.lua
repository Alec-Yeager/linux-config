return {
	{
		"stevearc/oil.nvim",
		lazy = false,
		opts = {
			win_options = { signcolumn = "yes:2" },
			view_options = { show_hidden = true },
		},
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = { "stevearc/oil.nvim" },
		config = true,
		opts = {
			show_ignored = false,
		},
	},
}
