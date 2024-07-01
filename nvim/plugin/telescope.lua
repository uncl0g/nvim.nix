if vim.g.did_load_telescope_plugin then
    return
end
vim.g.did_load_telescope_plugin = true

local telescope = require('telescope')
telescope.load_extension('fzy_native')

local function gitGrep()
    local git_root_dir = vim.fs.root(0, ".git")
    require('telescope.builtin').live_grep({ cwd = git_root_dir })
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>gg', gitGrep, { desc = '[G]it [G]rep' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>hh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[R]esume [S]earch' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = '[G]oto [R]eferences' })

telescope.setup {}
