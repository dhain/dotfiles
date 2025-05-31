vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- vim.opt allows setting lists as lua tables
vim.opt.backupdir = { '~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp' }
vim.opt.directory = { '~/.vim-tmp', '~/.tmp', '~/tmp', '/var/tmp', '/tmp' }

vim.o.history = 1000
vim.o.hidden = true
vim.o.mouse = 'a'

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

vim.g.bullets_checkbox_markers = " ◐●✓"

local n_opts = { silent = true, noremap = true }
local t_opts = { silent = true }
vim.keymap.set('n', '<cr>', ":nohlsearch<cr>", n_opts)
vim.keymap.set('n', '<leader><leader>', "<c-^>", n_opts)
vim.keymap.set('n', '<c-h>', "<c-w>h", n_opts)
vim.keymap.set('n', '<c-j>', "<c-w>j", n_opts)
vim.keymap.set('n', '<c-k>', "<c-w>k", n_opts)
vim.keymap.set('n', '<c-l>', "<c-w>l", n_opts)
vim.keymap.set('t', '<c-h>', "<c-\\><c-n><c-w>h", t_opts)
vim.keymap.set('t', '<c-j>', "<c-\\><c-n><c-w>j", t_opts)
vim.keymap.set('t', '<c-k>', "<c-\\><c-n><c-w>k", t_opts)
vim.keymap.set('t', '<c-l>', "<c-\\><c-n><c-w>l", t_opts)
vim.keymap.set('v', '<leader>y', '"*y')

vim.api.nvim_create_autocmd("BufLeave", { pattern = "*", command = "let b:winview = winsaveview()" })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "if(exists('b:winview')) | call winrestview(b:winview) | endif" })
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function(ev)
    if vim.bo[ev.buf].filetype == 'help' then
      vim.cmd.only()
      vim.bo[ev.buf].buflisted = true
    end
  end,
})

require("lazy-bootstrap")
require("lazy").setup("plugins")

-- local ollama_python = vim.fn.expand('$HOME/.pyenv/versions/ollama/bin/python3')
-- if vim.uv.fs_stat(ollama_python) then
--   vim.lsp.config("ollama-ls", { cmd = { ollama_python, "-m", "ollama_ls.cli" } })
--   vim.lsp.enable("ollama-ls")
-- end
