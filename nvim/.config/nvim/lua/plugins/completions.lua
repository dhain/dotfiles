-- Triggers snippets
local trigger_text = ';'

return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "moyiz/blink-emoji.nvim",
      { "Kaiser-Yang/blink-cmp-dictionary", dependencies = { "nvim-lua/plenary.nvim" } },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        dependencies = { "rafamadriz/friendly-snippets" }
      },
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("blink.cmp").setup({
        enabled = function()
          return not vim.tbl_contains({"TelescopePrompt", "snacks_picker_input"}, vim.bo.filetype)
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
            snippets = {
              name = "snippets",
              enabled = true,
              max_items = 15,
              min_keyword_length = 2,
              module = "blink.cmp.sources.snippets",
              score_offset = 85, -- the higher the number, the higher the priority
              -- Only show snippets if I type the trigger_text characters, so
              -- to expand the "bash" snippet, if the trigger_text is ";" I have
              -- to type ";bash"
              should_show_items = function()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
                -- NOTE: remember that `trigger_text` is modified at the top of the file
                return before_cursor:match(trigger_text .. "%w*$") ~= nil
              end,
              -- After accepting the completion, delete the trigger_text characters
              -- from the final inserted text
              -- Modified transform_items function based on suggestion by `synic` so
              -- that the luasnip source is not reloaded after each transformation
              -- https://github.com/linkarzu/dotfiles-latest/discussions/7#discussion-7849902
              -- NOTE: I also tried to add the ";" prefix to all of the snippets loaded from
              -- friendly-snippets in the luasnip.lua file, but I was unable to do
              -- so, so I still have to use the transform_items here
              -- This removes the ";" only for the friendly-snippets snippets
              transform_items = function(_, items)
                local line = vim.api.nvim_get_current_line()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local before_cursor = line:sub(1, col)
                local start_pos, end_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
                if start_pos then
                  for _, item in ipairs(items) do
                    if not item.trigger_text_modified then
                      item.trigger_text_modified = true
                      item.textEdit = {
                        newText = item.insertText or item.label,
                        range = {
                          start = { line = vim.fn.line(".") - 1, character = start_pos - 1 },
                          ["end"] = { line = vim.fn.line(".") - 1, character = end_pos },
                        },
                      }
                    end
                  end
                end
                return items
              end,
            },
          },
        },
        snippets = { preset = "luasnip" },
      })
    end
  },
}
