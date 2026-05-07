vim.filetype.add({
  extension = {
    bb = "clojure",
  },
})

vim.lsp.enable({
  "clojure_lsp",
  "css_variables",
  "cssls",
  "lua_ls",
  "pyright",
  "tailwindcss",
  "ts_lsp",
  "yamlls",
})

vim.diagnostic.config({
  -- virtual_lines = true,
  virtual_text = true,
  -- underline = true,
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

vim.api.nvim_create_user_command("LspActionFormat", function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })

    if #clients == 0 then
      vim.notify("No LSP client attached to this buffer", vim.log.levels.WARN)
      return
    end

    local supports_code_action = false
    local supports_format = false

    for _, client in ipairs(clients) do
      if client.server_capabilities.codeActionProvider then
        supports_code_action = true
      end
      if client.server_capabilities.documentFormattingProvider then
        supports_format = true
      end
    end

    if not supports_code_action then
      vim.notify("No attached LSP supports code actions", vim.log.levels.WARN)
      return
    end

    if not supports_format then
      vim.notify("No attached LSP supports formatting", vim.log.levels.WARN)
    end

    vim.lsp.buf.code_action({
      filter = function(action)
        return true
      end,
      apply = true,
    })

    -- Run format if available
    if supports_format then
      vim.lsp.buf.format({ async = true })
    end
  end,
  { desc = "Run code action and format" })
