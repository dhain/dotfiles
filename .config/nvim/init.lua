vim.g.CommandTPreferredImplementation = 'lua'
require("config.lazy")

vim.keymap.set('n', '<leader>t', "<cmd>CommandT<cr>")
vim.keymap.set('n', '<leader>b', "<cmd>CommandTBuffer<cr>")
