return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true,
    enable_check_bracket_line = false,
    ts_config = {
      clojure = { "string", "comment" },
    },
    map_cr = true,
    map_bs = true,
  },
  config = function(_, opts)
    local npairs = require("nvim-autopairs")
    npairs.setup(opts)

    local cmp_status_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
    if cmp_status_ok then
      local cmp = require("cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end
  end,
}
