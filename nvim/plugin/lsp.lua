if vim.g.did_load_lsp_plugins then
  return
end
vim.g.did_load_lsp_plugins = true

require("neodev").setup {}

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {}
lspconfig.nil_ls.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.gopls.setup {}
