vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.cursorline = true

vim.opt.wrap = false
vim.opt.eol = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.undodir = os.getenv('HOME') .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.o.completeopt = 'menuone,noselect'
vim.cmd "colorscheme gruvbox"
