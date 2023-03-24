local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		dependencies = {
		  -- format & linting
		  {
			"williamboman/mason-lspconfig.nvim",
			-- "github/copilot.vim",
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
			  require "custom.configs.null-ls"
			end,
		  },
		},
		config = function()
		  require "plugins.configs.lspconfig"
		  require "custom.configs.lspconfig"
		end, -- Override to setup mason-lspconfig
	},

	{
		"lewis6991/gitsigns.nvim",
		{
			"glepnir/lspsaga.nvim",
			opts = {
				lightbulb = { enable = false },
				symbol_in_winbar = { enable = false, },
			},
			config = true,
		},
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
    lazy = true,
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
    treesitter = true,
    dimming = {
      alpha = 0.25,
    },
  },

  {
	"github/copilot.vim",
    lazy = true,
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },

  {
	"iamcco/markdown-preview.nvim",
    lazy = true,
    run = "cd app && pnpm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" },
  },
}

return plugins
