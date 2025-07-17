return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    -- lazy = false,
    opts = {
      on_attach = require("nvchad.configs.lspconfig").on_attach,
      on_init = require("nvchad.configs.lspconfig").on_init,
      capabilities = require("nvchad.configs.lspconfig").capabilities,
    },
  },
  --
  -- {
  --   "windwp/nvim-ts-autotag",
  --   lazy = false,
  --   opts = {
  --     enable_close = true, -- Auto close tags
  --     enable_rename = true, -- Auto rename pairs of tags
  --   },
  -- },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
    },
  },

  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    opts = {},
  },

  {
    "stevearc/aerial.nvim",
    opts = {},
    lazy = false,
  },

  {
    "kevinhwang91/nvim-ufo",
    opts = {},
    dependencies = { "kevinhwang91/promise-async" },
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
