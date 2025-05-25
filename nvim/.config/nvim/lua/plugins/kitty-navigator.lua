return {
  "knubie/vim-kitty-navigator",
  lazy = false,
  cond = vim.env.TERM == "xterm-kitty",
  build = "cp ./*.py ~/.config/kitty/",
  cmd = {
    "KittyNavigateLeft",
    "KittyNavigateDown",
    "KittyNavigateUp",
    "KittyNavigateRight",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>KittyNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>KittyNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>KittyNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>KittyNavigateRight<cr>" },
  },
}
