return {
  "huggingface/llm.nvim",
  opts = {
    model = "qwen2.5-coder:1.5b",
    backend = "ollama",
    url = "http://foxy:11434",
    fim = {
      enabled = true,
      prefix = "<|fim_prefix|>",
      middle = "<|fim_middle|>",
      suffix = "<|fim_suffix|>",
    },
    lsp = {
      bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
    },
  }
}
