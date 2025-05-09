return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "gitcommit",
          "git_config",
          "gitignore",
          "git_rebase",
          "go",
          "html",
          "javascript",
          "jq",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "nginx",
          "perl",
          "python",
          "sql",
          "ssh_config",
          "terraform",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = false },
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
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  }
}
