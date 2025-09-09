vim.lsp.enable({
  "lua_ls",
  "clojure_lsp",
})

vim.diagnostic.config({
  virtual_lines = true,
  -- virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client and client.server_capabilities.documentFormattingProvider then
      vim.keymap.set(
        "n",
        "<leader>cf",
        function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
        { buffer = bufnr, desc = "Format buffer" }
      )
    end
  end
});

local orig_handler = vim.lsp.handlers["textDocument/codeAction"]

vim.lsp.handlers["textDocument/codeAction"] = function(err, actions, ctx, config)
  orig_handler(err, actions, ctx, config)
  -- rehighlight after applying
  vim.treesitter.get_parser():parse()
end
