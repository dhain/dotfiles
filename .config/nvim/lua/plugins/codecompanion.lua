return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            display = {
                diff = { enabled = false },
                chat = { show_settings = true },
            },
            strategies = {
                chat = {
                    adapter = "ollama"
                },
                inline = {
                    adapter = "ollama"
                },
                cmd = {
                    adapter = "ollama"
                }
            },
            adapters = {
                opts = { show_defaults = false },
                ollama = function ()
                    return require("codecompanion.adapters").extend("ollama", {
                        env = {
                            url = "http://foxy:11434",
                        },
                        headers = {
                            ["Content-Type"] = "application/json",
                        },
                        parameters = {
                            sync = true,
                        },
                        schema = {
                            model = {
                                default = "qwen2.5-coder:1.5b"
                            }
                        }
                    })
                end
            }
        },
    },
}
