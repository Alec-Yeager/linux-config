-- needs to be loaded LAST

local f = require("config.functions")

-- Oil
vim.keymap.set("n", "<leader>oe", "<cmd>Oil<CR>", { desc = "Open Oil" })
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open Oil" })
vim.keymap.set("n", "<leader>e", function()
	local width = math.min(math.floor(vim.o.columns / 3), 40)
	vim.cmd("leftabove " .. width .. "vsplit | oil")
	vim.wo.winfixwidth = true
end, { desc = "Open Oil on the side" })

-- Windows habits
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file" })
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo" })
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
vim.keymap.set("n", "<C-y>", "<C-r>", { desc = "Redo" })
vim.keymap.set("n", "<leader>u", "<cmd>Undotree<CR>", { desc = "Open undo tree" })

-- Config/Lazy
vim.keymap.set("n", "<leader>rc", "<cmd>restart<CR>", { desc = "Reload config" })
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>", { desc = "Open LazyVim" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy<CR>U", { desc = "Open LazyVim, Update plugins" })
vim.keymap.set("n", "<leader>sh", "<cmd>sp<CR>", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>sv", "<cmd>vs<CR>", { desc = "Split vertical" })

-- Buffers
vim.keymap.set("n", "<leader>x", "<cmd>q<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>bl", "<cmd>buffers<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>bs", ":b", { desc = "Switch buffers" })
vim.keymap.set("n", "<leader>b<left>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>b<right>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>q", ":bp | :bd #<Cr>", { silent = true, desc = "Close buffer" })
vim.keymap.set("n", "<leader>Q", ":bp | :bd! #<cR>", { silent = true, desc = "Force close buffer" })
vim.keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<CR>a")
vim.keymap.set("n", "<leader>th", "<cmd>split | terminal<CR>a")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", telescope.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", telescope.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", telescope.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fo", telescope.grep_string, { desc = "Telescope find string" })
vim.keymap.set("n", "<leader>fr", telescope.resume, { desc = "Reopen last search" })
vim.keymap.set("n", "<leader>fp", telescope.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fd", telescope.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fk", telescope.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>f/", telescope.current_buffer_fuzzy_find, { desc = "Fuzzy find in file" })
vim.keymap.set("n", "grr", telescope.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "gri", telescope.lsp_implementations, { desc = "LSP implementations" })
vim.keymap.set("n", "grt", f.goto_type, { desc = "Go to type" })
vim.keymap.set("n", "gO", telescope.lsp_document_symbols, { desc = "Document symbols" })
local function SearchDir()
	return require("oil").get_current_dir() or vim.fn.expand("%:p:h")
end
vim.keymap.set("n", "<leader>fF", function()
	telescope.find_files({ cwd = SearchDir() })
end, { desc = "Find files in current dir" })
vim.keymap.set("n", "<leader>fG", function()
	telescope.live_grep({ cwd = SearchDir() })
end, { desc = "Live grep in current dir" })
vim.keymap.set("n", "grh", "<cmd>LspClangdSwitchSourceHeader<cr>", { desc = "Switch Source/Header (C/C++)" })

-- git
local gs = require("gitsigns")
vim.keymap.set("n", "]h", function()
	gs.nav_hunk("next")
end, { desc = "Next hunk" })
vim.keymap.set("n", "[h", function()
	gs.nav_hunk("prev")
end, { desc = "Previous hunk" })
vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Discard hunk" })
vim.keymap.set("n", "<leader>gb", gs.blame_line, { desc = "Blame line" })
vim.keymap.set("n", "<leader>gv", ":DiffviewOpen<CR>", { desc = "Open git diff view" })
vim.keymap.set("n", "<leader>gdm", ":DiffviewOpen origin/master..HEAD<CR>", { desc = "Open git diff against master" })
vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>", { desc = "Close git diff view" })

-- markdown
vim.api.nvim_set_keymap("n", "<leader>mv", "<CMd>Markview<CR>", { desc = "Toggles `markview` previews globally." })

-- dap
local dap = require("dap")
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Condition: "))
end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<leader>dl", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log message: "))
end, { desc = "Logpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start / continue" })
vim.keymap.set("n", "<leader>dr", dap.run_last, { desc = "Re-run last config" }) -- skips the prompts
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Stack frame up" })
vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Stack frame down" })
vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dx", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
vim.keymap.set("n", "<leader>dv", "<cmd>DapViewToggle<CR>", { desc = "Toggle dap-view" })
vim.keymap.set("n", "<leader>dw", "<cmd>DapViewWatch<CR>", { desc = "Watch word under cursor" })
vim.keymap.set("n", "<leader>dK", "<cmd>DapViewHover<CR>", { desc = "Inspect value under cursor" })

-- For the ergo lol
_G.current_layout = "glove"
local allmodes = { "n", "v", "o" }
local qwerty_mappings = {

	{ { "n" }, "K", f.hover_or_lookup, "LSP Hover / Lookup" },
}

local glove_mappings = {

	{ allmodes, "t", "j", "Move down" },
	{ allmodes, "n", "k", "Move up" },
	{ allmodes, "s", "l", "Move right" },

	{ allmodes, "j", "t", "Till search forward" },
	{ allmodes, "k", "n", "Next search match" },
	{ allmodes, "l", "s", "Substitute character" },

	-- Uppercase variants
	{ allmodes, "T", "J", "Join lines" },
	{ { "n" }, "N", f.hover_or_lookup, "LSP Hover / Lookup" },
	{ allmodes, "S", "L", "Move to screen bottom" },

	{ allmodes, "J", "T", "Till search backward" },
	{ allmodes, "K", "N", "Previous search match" },
	{ allmodes, "L", "S", "Substitute line" },
}

f.apply_mappings(glove_mappings, "glove")

function toggle_keyboard_layout()
	if _G.current_layout == "qwerty" then
		f.clear_mappings(qwerty_mappings)
		f.apply_mappings(glove_mappings, "glove")
		print("Layout switched to glove")
	else
		f.clear_mappings(glove_mappings)
		f.apply_mappings(qwerty_mappings, "qwerty")
		print("Layout switched to qwerty")
	end
end

vim.keymap.set("n", "<leader>tk", toggle_keyboard_layout, { noremap = true, desc = "Toggle between qwerty and glove" })
