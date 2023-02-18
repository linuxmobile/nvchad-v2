local overrides = require("custom.plugins.overrides")

---@type NvPluginsTable
local plugins = {

	-- Override plugin definition options

	["neovim/nvim-lspconfig"] = {
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
   		-- "github/copilot.vim",
			-- format & linting
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("custom.plugins.null-ls")
			end,
		},

		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},

	["lewis6991/gitsigns.nvim"] = {
		{
			"glepnir/lspsaga.nvim",
			opts = {
				lightbulb = { enable = false },
				symbol_in_winbar = { enable = false, },
			},
			config = true,
		},
	},

	-- overrde plugin configs
	-- ["folke/which-key.nvim"] = {
	-- 	enabled = true,
	-- },

	["nvim-treesitter/nvim-treesitter"] = {
		override_options = overrides.treesitter,
	},

	["williamboman/mason.nvim"] = {
		override_options = overrides.mason,
	},

	["nvim-tree/nvim-tree.lua"] = {
		override_options = overrides.nvimtree,
	},

	-- Install a plugin
	["max397574/better-escape.nvim"] = {
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

  ["folke/twilight.nvim"] = {
    lazy = true,
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
    treesitter = true,
    dimming = {
      alpha = 0.25,
    },
  },

  ["github/copilot.vim"] = {
    lazy = true,
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },

  ["iamcco/markdown-preview.nvim"] = {
    lazy = true,
    run = "cd app && pnpm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" },
  },
	-- remove plugin
	-- ["hrsh7th/cmp-path"] = false,
}

return plugins
