return {
  "huggingface/llm.nvim",
  opts = {
    backend = "ollama",
    url = "http://foxy:11434",
    lsp = {
      bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
    },

    model = "codellama:code",
    tokens_to_clear = { "<EOT>" },
    fim = {
      enabled = true,
      prefix = "<PRE> ",
      middle = " <MID>",
      suffix = " <SUF>",
    },
    context_window = 4096,
    tokenizer = {
      repository = "codellama/CodeLlama-7b-hf",
    },

    -- model = "qwen2.5-coder:1.5b",
    -- tokens_to_clear = { "<|im_end|>" },
    -- fim = {
    --   enabled = true,
    --   prefix = "<|fim_prefix|>",
    --   middle = "<|fim_middle|>",
    --   suffix = "<|fim_suffix|>",
    -- },
    -- context_window = 32768,
    -- tokenizer = {
    --   repository = "Qwen/Qwen2.5-Coder-1.5B",
    -- },
  }
}
