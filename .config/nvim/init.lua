vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- vim.opt allows setting lists as lua tables
vim.opt.backupdir = { '~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp' }
vim.opt.directory = { '~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp' }

vim.o.history = 1000
vim.o.hidden = true
vim.o.mouse = 'a'
vim.o.conceallevel = 2

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.backspace = 'indent,eol,start'
vim.o.switchbuf = 'useopen,usetab'

vim.o.autoindent = true
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2

vim.o.showcmd = true
vim.o.scrolloff = 3

vim.o.number = true
vim.o.relativenumber = true
vim.o.list = true
vim.o.cursorline = true

vim.keymap.set('n', '<cr>', ":nohlsearch<cr>")
vim.keymap.set('n', '<leader><leader>', "<c-^>")
vim.keymap.set('n', '<c-h>', "<c-w>h")
vim.keymap.set('n', '<c-j>', "<c-w>j")
vim.keymap.set('n', '<c-k>', "<c-w>k")
vim.keymap.set('n', '<c-l>', "<c-w>l")
vim.keymap.set('v', '<leader>y', '"*y')

vim.api.nvim_create_autocmd("BufLeave", { pattern = "*", command = "let b:winview = winsaveview()" })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "if(exists('b:winview')) | call winrestview(b:winview) | endif" })

require("lazy-bootstrap")
require("lazy").setup("plugins")
