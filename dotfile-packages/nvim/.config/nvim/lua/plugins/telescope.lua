spec = {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- optional but recommended
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
        defaults = {
            path_display = { filename_first = { reverse_directories = false } },
        },
    },
}

return spec
