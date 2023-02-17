local overrides = require("custom.plugins.overrides")

---@type LazyPluginConfig[]
local plugins = {

  --- LSP-related settings
  -- First, remove mason.nvim from default nvchad to make sure it load on startup
  {
		"williamboman/mason.nvim",
    opts = overrides.mason,
  },
  -- As we are trying to "mimic" a more IDE like environment
  -- I believe having LSP enabled on startup is the easier approach
  {
		"neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require("custom.plugins.lspconfig")
    end,
    dependencies = {
      --- Add back mason here, and we will load it from lspconfig settings
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        -- code formatting, linting etc
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.plugins.null-ls")
        end,
      },
    },
  },
  {
		"lewis6991/gitsigns.nvim",
    dependencies = {
      -- Many people seems to use this for more fancy UI stuffs, so just commenting here 
      -- If you want to read more at https://github.com/glepnir/lspsaga.nvim
      -- I am adding it only to use its code actions UI window
      -- And as an example of using `opts = {...}` and `config = true` 
       {
        "glepnir/lspsaga.nvim",
        -- This table here is lspsaga config,
        -- Read more from their github page
        opts = {
          lightbulb = { enable = false },
          symbol_in_winbar = { enable = false, },
        },
        config = true,
      },
    }
  },

  --- DAP integration
  {
		"mfussenegger/nvim-dap",
    lazy = true,
    cmd = { "DapContinue", "DapToggleBreakpoint", },
    config = function()
      require("custom.plugins.dap")
    end,
    init = function()
      require("core.utils").load_mappings("dap")
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      -- VsCode-like UI
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
      -- Virtual text for notes
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
  },

  --- Tree-sitter related plugins
  -- overrde plugin configs
  {
		"nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    --- If you have use Vim before, you know how powerful textobjects are
    --- The plugin below is to enable its capabilities further
    --- If you want to then you can enable it and uncomment the `textobjects` section in `overrides.treesitter`
    -- dependencies = {
    --   { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- },
  },

  {
		"nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Re enable which-key
  {
		"folke/which-key.nvim",
    enabled = true,
  },

}

return plugins
