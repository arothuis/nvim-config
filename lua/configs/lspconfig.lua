require("nvchad.configs.lspconfig").defaults()

-- Enable every server from configs/languages.lua. Per-server settings live
-- in <config>/lsp/<name>.lua (Neovim 0.11+ runtime path lookup).
vim.lsp.enable(require("configs.languages").lsp_servers())

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN]  = "󰀪 ",
      [vim.diagnostic.severity.INFO]  = "󰋽 ",
      [vim.diagnostic.severity.HINT]  = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN]  = "WarningMsg",
    },
  },
})

-- Buffer-local format keymap when the server supports formatting
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.documentFormattingProvider then
      vim.keymap.set("n", "<leader>cf", function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, { buffer = bufnr, desc = "Format buffer (LSP)" })
    end
    -- NvChad's on_attach binds <leader>ra to the renamer; we expose it via
    -- <leader>cr / grn instead, so drop the duplicate.
    pcall(vim.keymap.del, "n", "<leader>ra", { buffer = bufnr })
  end,
})

-- Re-parse treesitter after applying a code action so highlights stay correct
local orig_handler = vim.lsp.handlers["textDocument/codeAction"]
vim.lsp.handlers["textDocument/codeAction"] = function(err, actions, ctx, config)
  orig_handler(err, actions, ctx, config)
  local ok, parser = pcall(vim.treesitter.get_parser)
  if ok and parser then parser:parse() end
end
