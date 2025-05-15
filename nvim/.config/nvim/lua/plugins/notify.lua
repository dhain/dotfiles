return {
  "rcarriga/nvim-notify",
  config = function()
    local n = require("notify")
    n.setup({
      background_colour = "#000000"
    })
    vim.notify = n
    vim.keymap.set("n", "<leader>n", require("telescope").extensions.notify.notify)
  end
}
