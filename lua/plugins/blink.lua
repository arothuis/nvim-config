return {
  {
    "saghen/blink.compat",
    version = "2.*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    version = "1.*",
    opts = {
      keymap = { preset = "enter" },
      completion = { documentation = { auto_show = true } },
    },
    dependencies = {
      { "rafamadriz/friendly-snippets" },
      { "PaterJason/cmp-conjure" },

    },
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "conjure"
      },
      providers = {
        conjure = {
          name = "conjure",
          module = "blink.compat.source",
        }
      },
    }
  }
}
