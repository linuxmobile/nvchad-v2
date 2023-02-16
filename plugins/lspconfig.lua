local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
--- These are the servers' name
--- To know the list of readily available servers
--- Read more at `:h lspconfig-all`, or https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md


--- General LSP settings {{{
--- You can also override the default handlers for a language server request
--- For example, adding borders to diagnostics floating window
vim.diagnostic.config({
  float = {
    border = "rounded"
  }
})
-- Or overriding the text hover handler to have rounded borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"})
---}}}

---{{{
--- Linters/Formatter/Language Servers Manager: Mason
--- Find the list of available executable by using the command :Mason
--- And then add what you want to add inside `overrides.lua`, the `ensure_installed` table under `M.mason` 
--- Afterwards, reopen Neovim and run `:MasonInstallAll`
require("plugins.configs.mason")


-- Refer to :h mason-lspconfig-settings for more information
-- mason-lspconfig is specifically for language servers only, and it maps mason's executable to `lspconfig`'s server names
-- So check the server names from lspconfig to see the list of servers
-- (If you define a lot of servers here, the first open may take a while)
local servers = { "html", "cssls", "tsserver", "clangd" }
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})
---}}}

------------------------Server setup---------------------------------
---{{{
require("mason-lspconfig").setup_handlers({
  -- Servers using default configuration from lspconfig (init_options, server settings)
  -- Check :h lspconfig-all for more information
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `lua_ls`:
  ["lua_ls"] = function ()
    lspconfig["lua_ls"].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.env.VIMRUNTIME .. "/lua"] = true,
              [vim.fn.stdpath("data") .. "/lazy/extensions/nvchad_types"] = true,
            },
          },
          runtime = {
            pathStrict = true,
          },
          telemetry = {
            enable = false,
          },
        }
      }
    })
  end,

  --- Another example, for clangd
  --- It usually runs into mismatched encodings issues with `null-ls`
  --- So we override to make sure clangd uses utf-16 encodings
  --- This is an example for unix-based
  ["clangd"] = function()
    lspconfig.clangd.setup({
			cmd = {
				"clangd",
				"--background-index",
				"--offset-encoding=utf-16", -- temporary fix to stop null-ls
				"--enable-config",
				"--completion-style=detailed",
				"--clang-tidy",
				"--all-scopes-completion",
				"--pch-storage=memory",
				"--suggest-missing-includes",
			},
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end
})
---}}}
