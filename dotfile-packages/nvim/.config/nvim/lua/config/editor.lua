vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.o.winborder = "rounded"
vim.diagnostic.config({ virtual_text = true })
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.o.inccommand = "split"
vim.cmd.packadd("nvim.undotree")
vim.cmd.packadd("nohlsearch")

for _, group in ipairs({ "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }) do
	vim.api.nvim_set_hl(0, group, { bg = "#2a2a2a" })
end
