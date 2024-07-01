if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

local gs = require 'gitsigns'

gs.setup {
    on_attach = function (bufnr)
        -- Navigation
        vim.keymap.set('n', ']c', gs.prev_hunk, { desc = 'Go to Previous Hunk', buffer = bufnr })
        vim.keymap.set('n', '[c', gs.next_hunk, { desc ='Go to Next Hunk', buffer = bufnr })
        vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { desc ='[P]review [H]unk', buffer = bufnr })

        -- Actions
        vim.keymap.set('n', '<leader>hs', gs.stage_hunk, { desc ='[S]tage [H]unk', buffer = bufnr })
        vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = '[S]tage [H]unk', buffer = bufnr })

        vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { desc ='[R]eset [H]unk', buffer = bufnr })
        vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,{ desc ='[R]eset [H]unk', buffer = bufnr })

        vim.keymap.set('n', '<leader>hd', gs.diffthis,{ desc ='[H]unk diff', buffer = bufnr })
        vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)

        vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame)

        -- Remove sign column highlight
        vim.api.nvim_set_hl(0, 'SignColumn', { link = 'NONE' })
    end
}
