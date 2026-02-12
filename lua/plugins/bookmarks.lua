return {
  'tomasky/bookmarks.nvim',
  config = function()
    require('telescope').load_extension('bookmarks')
    require("bookmarks").setup({
      keywords = {
        ["@x"] = "*"
      },
    })
  end,
}
