return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("ui-select")
    telescope.load_extension("noice")

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.97,
            height = 0.98,
            preview_height = 0.5,
            preview_cutoff = 0,
            mirror = false,
          },
        },
        path_display = {
          filename_first = {
            reverse_directories = true
          }
        }
      }
    })
  end,
}
