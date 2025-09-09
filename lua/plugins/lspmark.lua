return {
  "tristone13th/lspmark.nvim",
  opts = {},
  config = function()
    require("telescope").load_extension("lspmark")

    vim.api.nvim_create_autocmd({ "DirChanged" }, {
      callback = require("lspmark.bookmarks").load_bookmarks,
      pattern = { "*" },
    })
  end
}
