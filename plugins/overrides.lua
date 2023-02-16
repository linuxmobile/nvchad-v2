local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "c",
  },
  -- textobjects = {
  --   enable = true,
  --   lookahead = true,
  --   include_surrounding_whitespace = true,
  --   keymaps = {
  --     ["af"] = "@function.outer",
  --     ["if"] = "@function.inner",
  --     ["ac"] = "@class.outer",
  --     ["ic"] = "@class.inner",
  --   },
  -- }
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",

    -- DAP stuff 
    "cpptools"
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
