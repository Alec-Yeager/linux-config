return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        { "neovim/nvim-lspconfig" },
    },
    opts = {
        -- MOVED TO mason-tool-installer
        -- ensure_installed = { "lua_ls", "clangd", "rust_analyzer", "ruff", "basedpyright" },
    },
    config = function(_, opts)
        -- system bespoke lsp config
        local status_ok, local_lsp = pcall(require, "config.local_lsp")
        if status_ok then
            local_lsp.setup()
        end
        require("mason-lspconfig").setup(opts)
        vim.lsp.inlay_hint.enable(false)
    end,
}
