vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local buf = args.buf
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
        -- Add autoformatting on save
        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("my.lsp.format." .. buf, { clear = true }),
                buffer = buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end
    end,
})
