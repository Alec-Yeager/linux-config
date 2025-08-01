vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.cmd [[highlight TabLineFill ctermfg=black]]
--vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
--vim.api.nvim_set_hl(0, "NormalNC", { bg = "none"})

vim.schedule(function()
  require "mappings"
end)

-- Set up for Godot projects.

local project = require "project"

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat(project.godot_project_path .. "/server.pipe")
-- start server, if not already running
if project.is_godot_project and not is_server_running then
  vim.fn.serverstart(project.godot_project_path .. "/server.pipe")
end
