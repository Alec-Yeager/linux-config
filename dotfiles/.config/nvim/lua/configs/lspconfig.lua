-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "cssls", "clangd", "pyright" }
local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

lspconfig.lua_ls.setup({
  cmd = { "lua-language-server" },
})

-- lspconfig.pyright.setup({
--   cmd = {
--     "node",
--     vim.fn.stdpath("data") .. "/mason/packages/pyright/node_modules/pyright/langserver.index.js",
--     "--stdio"
--   },
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- })

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    --client.server_capabilities.signatureHelpProvider = false
    nvlsp.on_attach(client, bufnr)
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- configuring single server, example: typescript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

local project = require "project"

if project.is_godot_project then
  lspconfig.gdscript.setup {}
end
