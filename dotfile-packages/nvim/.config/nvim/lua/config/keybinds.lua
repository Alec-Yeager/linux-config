-- needs to be loaded LAST

local f = require("config.functions")

vim.keymap.set("n", "<leader>oe", "<cmd>Oil<CR>", { desc = "Open NetRW" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
vim.keymap.set("n", "<C-z>", "u", { desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Undo" })
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", { desc = "Redo" })
vim.keymap.set("n", "<C-y>", "<C-r>", { desc = "Redo" })

vim.keymap.set("n", "<C-h>", ":noh<CR>")
vim.keymap.set("i", "<C-h>", "<Esc>:noh<CR>a")

vim.keymap.set("n", "<leader>rc", ":restart<CR>", { desc = "Reload config" })
vim.keymap.set("n", "<leader>x", ":q<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>ll", ":Lazy<CR>", { desc = "Open LazyVim" })
vim.keymap.set("n", "<leader>lu", ":Lazy<CR>U", { desc = "Open LazyVim, Update plugins" })
vim.keymap.set("n", "<leader>sh", ":sp<CR>", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>sv", ":vs<CR>", { desc = "Split vertical" })

vim.keymap.set("n", "<leader>bl", ":buffers<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>bs", ":b", { desc = "Switch buffers" })

vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>a")
vim.keymap.set("n", "<leader>th", ":split | terminal<CR>a")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fo", builtin.grep_string, { desc = "Telescope find string" })

-- For the ergo lol
_G.current_layout = "glove"
local allmodes = { "n", "v", "o" }
local qwerty_mappings = {

    { { "n" }, "K", f.hover_or_lookup, "LSP Hover / Lookup" },
}

local glove_mappings = {

    { allmodes, "t", "j",               "Move down" },
    { allmodes, "n", "k",               "Move up" },
    { allmodes, "s", "l",               "Move right" },

    { allmodes, "j", "t",               "Till search forward" },
    { allmodes, "k", "n",               "Next search match" },
    { allmodes, "l", "s",               "Substitute character" },

    -- Uppercase variants
    { allmodes, "T", "J",               "Join lines" },
    { { "n" },  "N", f.hover_or_lookup, "LSP Hover / Lookup" },
    { allmodes, "S", "L",               "Move to screen bottom" },

    { allmodes, "J", "T",               "Till search backward" },
    { allmodes, "K", "N",               "Previous search match" },
    { allmodes, "L", "S",               "Substitute line" },
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
