return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = {
        transparent_background = true,
        integrations = { treesitter = true },
    } },
    { "wincent/command-t", main = "wincent.commandt", opts = {} },
    { "nvim-treesitter/nvim-treesitter", build= ":TSUpdate", opts = {
        ensure_installed = {
            "c", "lua", "python", "javascript", "markdown", "bash", "css",
            "git_config", "git_rebase", "gitcommit", "gitignore", "go",
            "html", "jq", "json", "make", "markdown_inline", "nginx",
            "perl", "sql", "ssh_config", "terraform", "yaml"
        },
        sync_install = false,
        auto_install = true,
        highlight = { enable = true }
    } },
}
