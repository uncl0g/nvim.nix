if vim.g.did_load_lspconfig_plugin then
  return
end
vim.g.did_load_lspconfig_plugin = true

require("neodev").setup {}

local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup {}
lspconfig.nil_ls.setup {}
lspconfig.rust_analyzer.setup {}
