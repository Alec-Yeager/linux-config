spec = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	opts = {
		defaults = {
			path_display = { filename_first = { reverse_directories = false } },
		},
		pickers = {
			-- Need to have all these damn things ignore .git if I want hidden files.
			find_files = {
				find_command = { "rg", "--files", "--color", "never", "--hidden", "--glob", "!**/.git*" },
				follow = true,
			},
			live_grep = { additional_args = { "--hidden", "--follow", "--glob=!**/.git/*" } },
			grep_string = { additional_args = { "--hidden", "--follow", "--glob=!**/.git/*" } },
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
	end,
}

return spec
