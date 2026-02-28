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
map("n", "<leader>v", "")
-- Open vertical split
map("n", "<leader>v", ":vsplit<CR>")
map("n", "<leader>h", ":split<CR>")

-- Open vertical terminal
map("n", "<leader>tv", ":vsplit | terminal<CR>")
map("n", "<leader>th", ":split | terminal<CR>")

map("n", "<C-Right>", ":vertical res +1<CR>")
map("n", "<C-Left>", ":vertical res -1<CR>")
map("n", "<C-Up>", ":res +1<CR>")
map("n", "<C-Down>", ":res -1<Cr>")

map({ "n", "v" }, "<HOME>", function()
  local col = vim.fn.col "."
  local line = vim.fn.getline "."
  local first_nonblank = vim.fn.match(line, "\\S") + 1
  return col == first_nonblank and "0" or "^"
end, { expr = true, silent = true })

map({ "i" }, "<HOME>", function()
  local col = vim.fn.col "."
  local line = vim.fn.getline "."
  local first_nonblank = vim.fn.match(line, "\\S") + 1
  return col == first_nonblank and "<C-o>0" or "<C-o>^"
end, { expr = true, silent = true })

map("i", "<C-z>", "<C-o>u")
map("i", "<C-Z>", "<C-o><C-r>")

-- define functions only for Godot projects
local project = require "project"
if project.is_godot_project then
  -- write breakpoint to new line
  vim.api.nvim_create_user_command("GodotBreakpoint", function()
    vim.cmd "normal! obreakpoint"
    vim.cmd "write"
  end, {})
  vim.keymap.set("n", "<leader>GN", ":GodotBreakpoint<CR>")

  -- delete all breakpoints in current file
  vim.api.nvim_create_user_command("GodotDeleteBreakpoints", function()
    vim.cmd "g/breakpoint/d"
  end, {})
  vim.keymap.set("n", "<leader>GD", ":GodotDeleteBreakpoints<CR>")

  -- search all breakpoints in project
  vim.api.nvim_create_user_command("GodotFindBreakpoints", function()
    vim.cmd ":grep breakpoint | copen"
  end, {})
  vim.keymap.set("n", "<leader>GF", ":GodotFindBreakpoints<CR>")

  -- append "# TRANSLATORS: " to current line
  vim.api.nvim_create_user_command("GodotTranslators", function(opts)
    vim.cmd "normal! A # TRANSLATORS: "
  end, {})
end

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
