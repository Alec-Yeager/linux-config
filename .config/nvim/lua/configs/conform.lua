local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    cpp = { "clang-format" },
    python = { "black" },
  },
  format_on_save = {
    --   -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
    -- lsp_fallback = true,
  },
}

return options
