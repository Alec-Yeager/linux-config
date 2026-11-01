return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim" },
    opts = {
        ensure_installed = {
            "tree-sitter-cli",
            "prettier",
            "clangd",
            "ruff",
            "lua_ls",
            "bash-language-server",
            "rust_analyzer",
            "basedpyright"
        },

        run_on_start = true,
    },
}
