local overrides = require "custom.plugins.overrides"

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
      require "custom.plugins.lspconfig"
    end,
    --- Add back mason here, and we will load it from lspconfig settings
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        -- code formatting, linting etc
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.plugins.null-ls")
        end
      },
    },
  },

  --- Tree-sitter related plugins
  -- overrde plugin configs
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
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


  -- Re enable which-key
  ["folke/which-key.nvim"] = {
    enabled = true,
  },

  -- remove plugin
  -- ["hrsh7th/cmp-path"] = false,
}

return plugins
