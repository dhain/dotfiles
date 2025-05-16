return {
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "3rd/image.nvim",
    build = false,
    opts = {
      integrations = {
        markdown = { enabled = true, },
        neorg = { enabled = false, },
        typst = { enabled = false, },
        html = { enabled = false, },
        css = { enabled = false, },
      },
    }
  },
}
