return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.35,
      provider = "auto",
      auto_close = true,
    },
    diff_opts = {
      layout = "vertical",
      open_in_new_tab = false,
    },
  },
}
