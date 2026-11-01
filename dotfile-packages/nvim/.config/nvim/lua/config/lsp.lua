vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),
    callback = function(args)
        local buf = args.buf
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buf })
    end,
})
