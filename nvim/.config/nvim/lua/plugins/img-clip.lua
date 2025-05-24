return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    default = {
      prompt_for_file_name = false, ---@type boolean | fun(): boolean
      file_name = "%Y%m%d-%H%M%S", ---@type string | fun(): string
    },
  },
  keys = {
    { "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
