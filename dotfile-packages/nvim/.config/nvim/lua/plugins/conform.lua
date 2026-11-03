local prettier = { "prettier" }

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
        -- Anything not listed here keeps formatting through its language server
        formatters_by_ft = {
            css = prettier,
            html = prettier,
            javascript = prettier,
            javascriptreact = prettier,
            json = prettier,
            jsonc = prettier,
            markdown = prettier,
            scss = prettier,
            typescript = prettier,
            typescriptreact = prettier,
            vue = prettier,
            yaml = prettier,
        },
        format_on_save = { timeout_ms = 1000, lsp_format = "fallback" },
    },
}
