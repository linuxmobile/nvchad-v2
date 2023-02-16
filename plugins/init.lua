local overrides = require("custom.plugins.overrides")

---@type {[PluginName]: NvPluginConfig|false}
local plugins = {

  --- LSP-related settings
  -- First, remove mason.nvim from default nvchad to make sure it load on startup
  ["williamboman/mason.nvim"] = false,
  -- As we are trying to "mimic" a more IDE like environment
  -- I believe having LSP enabled on starup is a more "sane" approach
  ["neovim/nvim-lspconfig"] = {
    rm_default_opts = true,
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
      -- Many people seems to use this for more fancy UI stuffs, so just commenting here 
      -- If you want to look more into it
      -- { "glepnir/lspsaga.nvim" }
    },
  },

  --- DAP integration
  ["mfussenegger/nvim-dap"] = {
    lazy = true,
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
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
    },
  },

  ["nvim-tree/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  -- Re enable which-key
  ["folke/which-key.nvim"] = {
    enabled = true,
  },

  -- remove plugin
  -- ["hrsh7th/cmp-path"] = false,
}

return plugins
