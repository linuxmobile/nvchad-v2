local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

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

local servers = { "html", "cssls", "astro", "tailwindcss", "tsserver" }

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
