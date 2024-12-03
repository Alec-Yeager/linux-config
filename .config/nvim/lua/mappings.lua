require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Add breakpoint at line" })
map("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "Start or continue debugger" })
map("", "<leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
map("n", "zR", require("ufo").openAllFolds, { desc = "open ufo folds" })
map("n", "zM", require("ufo").closeAllFolds, { desc = "close ufo folds" })
map("n", "<leader>a", "<cmd> AerialToggle! <CR>", { desc = "Toggle Aerial overview" })

local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
  },
}

return M

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
