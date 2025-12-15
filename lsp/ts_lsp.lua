return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {},
}
