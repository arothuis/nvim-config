return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {},
    config = function()
      require("mason").setup()

      local servers = {
        "lua_ls",
        "clojure_lsp",
        "svelte",
        "tailwindcss",
        "cssls",
        "css_variables",
        "ts_ls",
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      for _, name in ipairs(servers) do
        vim.lsp.enable(name)
      end
    end
  },
}
