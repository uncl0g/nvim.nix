if vim.g.did_load_oil_plugin then
  return
end
vim.g.did_load_oil_plugin = true

require("oil").setup {}
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = "Open partent diretory" })
