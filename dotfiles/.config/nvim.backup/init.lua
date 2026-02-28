vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
--vim.opt.rtp:append(os.getenv("COLORSCHEME_FOLDER"))

local set = vim.opt -- set options
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.number = true
set.guicursor = "a:blinkon100"
set.termguicolors = true
--set.background = "dark"

vim.cmd([[set clipboard+=unnamedplus]])

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

--[[
local colorscheme_file = vim.fn.expand(os.getenv("COLORSCHEME_FOLDER")..'/Current.conf')
local function set_colorscheme(name)
	local filebytes = vim.fn.readfile(os.getenv("COLORSCHEME_FOLDER")..'%s.conf', "b")
	vim.fn.writefile(filebytes, colorscheme_file, "B")
	--	vim.cmd('colorscheme '..name)
	vim.loop.spawn('kitty', {
		args = {
			'@',
			'set-colors',
			'-c',
			string.format(os.getenv("COLORSCHEME_FOLDER")..'/Current.conf')
		}
	}, nil)
end
--]]

--local lineTheme = require('lualine.themes.onedark')

require("lazy").setup({
	{	"nyoom-engineering/oxocarbon.nvim",
	lazy=false,
	priority=1000,
	config=function()
		vim.cmd([[colorscheme oxocarbon]])
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
		vim.cmd('hi! LineNr guibg=None ctermbg=None')
	end
},
--{ "eriedaberrie/colorscheme-file.nvim",
--opts = {
	--	fallback = os.getenv("COLORSCHEME_FOLDER")..'/Wryan.conf',
	--	path = os.getenv("COLORSCHEME_FOLDER")..'/Current.conf',
	--}},
	{	"tpope/vim-repeat",
	tag = "v1.2"
},
{		'ggandor/leap.nvim',
config = function()
	require('leap').create_default_mappings()
end
},
{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
{ "nvim-treesitter/nvim-treesitter", 
build = {
	":TSInstall bash", 
	":TSInstall c", 
	":TSInstall cmake", 
	":TSInstall cuda", 
	":TSInstall cpp", 
	":TSInstall glsl", 
	":TSInstall lua", 
	":TSInstall python", 
	":TSInstall rust", 
	":TSInstall vim",
	":TSInstall typescript",
	":TSInstall vimdoc",
	":TSUpdate"
},
lazy=false,
-- can't just be opts, since it's the .config instead of std main
main = 'nvim-treesitter.configs',
opts =  {
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
	},
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-tree/nvim-tree.lua",
	opts = {
		view = {
			width = 30,
		},
		filters = {
			dotfiles = true,
		}
	}
},
{
	"L3MON4D3/LuaSnip",
	--	build = "make install_jsregexp"
},
{
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		local lualine = require('lualine')
		lualine.setup({
			options = {
				icons_enabled = true,
				theme = 'palenight',
				component_separators = { left = '', right = ''},
				section_separators = { left = '', right = ''},
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'progress'},
				lualine_z = {'location'}
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		})
	end
},
{ "williamboman/mason.nvim", 
build = {
	":MasonInstall stylua lua-language-server",
	":MasonInstall clangd cpptools cpplint clang-format",
	":MasonInstall debugpy python-lsp-server ruff",
	":MasonUpdate",
},
opts = {},
},
{ "norcalli/nvim-colorizer.lua" },
{ "nvim-lua/plenary.nvim" },
{ "nvim-telescope/telescope.nvim" },
{ "williamboman/mason-lspconfig.nvim" },
{ "mfussenegger/nvim-lint" },
{ "mhartington/formatter.nvim" },
{ "hrsh7th/cmp-buffer" },
{ "hrsh7th/cmp-nvim-lsp", },
{ "hrsh7th/cmp-nvim-lsp-signature-help", },
{ "hrsh7th/cmp-nvim-lsp-document-symbol" },
{ "hrsh7th/cmp-path" },
{ "hrsh7th/cmp-cmdline" }, 
{ "hrsh7th/nvim-cmp",  
config = function ()
	local cmp = require('cmp')
	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
			end
		},
		window = {
			--			completion = cmp.config.window.bordered(),
			--			documentation = cmp.config.window.bordered()
		},
		mapping = cmp.mapping.preset.insert({
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			-- I straight stole this shit
			['<Tab>'] = cmp.mapping(function(fallback)
				local col = vim.fn.col('.') - 1

				if cmp.visible() then
					cmp.select_next_item(select_opts)
				elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
					fallback()
				else
					cmp.complete()
				end
			end, {'i', 's'}),

			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item(select_opts)
				else
					fallback()
				end
			end, {'i', 's'}),
		}),
		sources = cmp.config.sources({
			{ name = 'luasnip', option = {show_autosnippets = false} },
		}, {
			{ name = 'buffer' },
			{ name = 'nvim_lsp' },
			{ name = 'nvim_lsp_signature_help' },
			{ name = 'path' ,
			option = {
				trailing_slash = true	
			}
		}
	})
})
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
cmp.setup.cmdline('/', {
	sources = cmp.config.sources({
		{ name = 'nvim_lsp_document_symbol' }
	}, {
		{ name = 'buffer' }
	})
})
end 
},
{ "neovim/nvim-lspconfig",
config = function()
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	local lspconfig = require('lspconfig')
	lspconfig.clangd.setup {
		capabilities = capabilities,
	}
end
},
{	"saadparwaiz1/cmp_luasnip",	},
{	"mfussenegger/nvim-dap",	},
{ "nvim-neotest/nvim-nio" },
{ "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
})

set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldenable = false

vim.api.nvim_create_user_command('T', ":NvimTreeToggle", {})


