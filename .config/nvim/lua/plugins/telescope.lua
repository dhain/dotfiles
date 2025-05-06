return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local ts = require("telescope")
    ts.setup()
    ts.load_extension("ui-select")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>t", builtin.find_files)
    vim.keymap.set("n", "<leader>g", builtin.live_grep)
    vim.keymap.set("n", "<leader>b", builtin.buffers)
  end
}
