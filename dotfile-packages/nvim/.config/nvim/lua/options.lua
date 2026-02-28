require "nvchad.options"

-- add yours here!

vim.diagnostic.config {
  virtual_text = false,
}

vim.wo.relativenumber = true

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.winborder = "rounded"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
