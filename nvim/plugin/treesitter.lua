if vim.g.did_load_treesitter_plugin then
  return
end
vim.g.did_load_treesitter_plugin = true

local configs = require('nvim-treesitter.configs')

---@diagnostic disable-next-line: missing-fields
configs.setup {
  highlight = { enable = true },
}
