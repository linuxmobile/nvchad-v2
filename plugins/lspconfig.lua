local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "tsserver", "clangd" }

require("plugins.configs.mason")
-- Refer to :h mason-lspconfig-settings for more information
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

----------------No Mason-lsp advanced setup---------------------------------
---{{{
-- Servers with default configuration (init_options, server settings)
-- Check :h lspconfig-all for more information
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- If you want to set custom lspconfig servers, set it here
-- For example, NvChad's default lspconfig for sumneko_lua
lspconfig["sumneko_lua"].setup({
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
---}}}
