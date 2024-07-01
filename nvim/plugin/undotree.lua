if vim.g.did_load_undotree_plugin then
  return
end
vim.g.did_load_undotree_plugin = true

vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<cr>', { desc = "Toggle the [U]ndotree" })
