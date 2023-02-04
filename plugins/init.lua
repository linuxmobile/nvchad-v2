local overrides = require "custom.plugins.overrides"

---@type {[PluginName]: NvPluginConfig|false}
local plugins = {

  --- LSP-related settings
  ["williamboman/mason.nvim"] = {
    rm_default_opts = true,
  },
  ["williamboman/mason-lspconfig.nvim"] = {},
  ["neovim/nvim-lspconfig"] = {
    rm_default_opts = true,
    config = function()
      require "custom.plugins.lspconfig"
    end,
  },
  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
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


  -- remove plugin
  -- ["hrsh7th/cmp-path"] = false,
}

return plugins
