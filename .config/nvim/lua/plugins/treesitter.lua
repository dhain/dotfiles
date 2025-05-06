return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "lua", "python", "javascript", "markdown", "bash", "css",
        "git_config", "git_rebase", "gitcommit", "gitignore", "go",
        "html", "jq", "json", "make", "markdown_inline", "nginx",
        "perl", "sql", "ssh_config", "terraform", "yaml"
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          }
        }
      }
    })
  end
}
