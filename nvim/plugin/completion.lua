if vim.g.did_load_completion_plugin then
  return
end
vim.g.did_load_completion_plugin = true

local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

cmp.setup.filetype('lua', {
  sources = cmp.config.sources {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
  },
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = 'cmdline' },
  },
})
