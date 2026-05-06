return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    config = function()
      vim.g.opencode_opts = {}
      vim.o.autoread = true
    end,
  },
}
