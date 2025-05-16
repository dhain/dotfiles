return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "moyiz/blink-emoji.nvim",
      { "Kaiser-Yang/blink-cmp-dictionary", dependencies = { "nvim-lua/plenary.nvim" } },
      { "L3MON4D3/LuaSnip", version = "v2.*" },
    },
    opts = {
      enabled = function()
        return not vim.tbl_contains({"TelescopePrompt"}, vim.bo.filetype)
      end,
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji", "dictionary" },
        min_keyword_length = function()
          return vim.bo.filetype == 'markdown' and 2 or 0
        end,
        providers = {
          lsp = {
            name = "lsp",
            module = "blink.cmp.sources.lsp",
            score_offset = 90,
            timeout_ms = 200,
            fallbacks = {},
          },
          emoji = {
            module = "blink-emoji",
            name = "Emoji",
            score_offset = 93,
            opts = { insert = true },
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            min_keyword_length = 3,
            max_items = 8,
            score_offset = 15,
            opts = {
              dictionary_files = { "/etc/dictionaries-common/words" },
            },
          },
        },
      },
      snippets = { preset = "luasnip" },
    },
  },
}
