return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  cond = function()
    local path = ""
    if vim.loop.os_uname().sysname == "Darwin" then
      path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Garden"
    else
      path = "~/mnt/borf/Library/Mobile Documents/iCloud~md~obsidian/Documents/Garden"
    end
    return vim.fn.isdirectory(path)
  end,
  config = function()
    local path = ""
    if vim.loop.os_uname().sysname == "Darwin" then
      path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Garden"
    else
      path = "~/mnt/borf/Library/Mobile Documents/iCloud~md~obsidian/Documents/Garden"
    end
    require("obsidian").setup({
      workspaces = {
        {
          name = "Garden",
          path = path,
        },
      },
      templates = {
        folder = "Templates",
        substitutions = {
          ["date:dddd, MMMM DD YYYY"] = function()
            return os.date("%A, %B %d %Y")
          end
        },
      },
      daily_notes = {
        template = "Daily Note.md",
      },
      attachments = {
        img_folder = "Attachments",
      },
      note_path_func = function(spec)
        local path = spec.dir / tostring(spec.title)
        return path:with_suffix(".md")
      end,
      wiki_link_func = "use_alias_only",
      disable_frontmatter = true,
      follow_url_func = vim.ui.open,
    })
  end
}
