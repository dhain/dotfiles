return {
  "epwalsh/obsidian.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  cond = function()
    return vim.env.OBSIDIAN_VAULT
  end,
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = vim.env.OBSIDIAN_VAULT_NAME or "Default",
          path = vim.env.OBSIDIAN_VAULT,
        }
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
