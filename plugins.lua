---@diagnostic disable: different-requires
local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    {
      "glepnir/lspsaga.nvim",
      opts = {
        lightbulb = { enable = false },
        symbol_in_winbar = { enable = false },
      },
      config = true,
    },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css", "astro" },
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    ft = { "markdown", "lua", "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css", "astro" },
    treesitter = true,
    dimming = {
      alpha = 0.25,
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require "custom.configs.copilot"
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    run = "cd app && pnpm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      require "custom.configs.presence"
    end,
  },
}

return plugins
