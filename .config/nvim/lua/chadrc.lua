-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "voz",
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  transparency = true,
  integrations = {
    "blankline",
    "cmp",
    "git",
  },
  mason = {
    cmd = true,
    pkgs = {
      "clangd",
      "clang-format",
      "codelldb",
      "black",
      "pyright",
      "prettier",
      "emmet-language-server",
    },
  },
  -- plugins = "custom.plugins",
}

-- M.mason = {
--   cmd = true,
--   pkgs = {
--     "clangd",
--     "clang-format",
--     "codelldb",
--   },
-- }

-- M.ui = {
--   statusline = {
--     theme = "default",
--     seperator_style = "block",
--     order = nil,
--     modules = nil,
--   },
-- }
return M
