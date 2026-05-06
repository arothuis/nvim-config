return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Auto-install LSP servers from configs/languages.lua
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      return { ensure_installed = require("configs.languages").lsp_servers() }
    end,
  },

  -- Treesitter: extend NvChad's spec with parsers, textobjects, etc.
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(
        opts.ensure_installed or {},
        require("configs.languages").treesitter_parsers()
      )
      opts.highlight = vim.tbl_extend("force", opts.highlight or {}, { enable = true })
      opts.indent = { enable = true }
      opts.incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      }
      opts.textobjects = {
        move = {
          enable = true,
          goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.outer" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.outer" },
        },
      }
      return opts
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.treesitter.language.register("jinja", "njk")
      vim.filetype.add({ extension = { njk = "html" } })
    end,
  },

  -- which-key: match nvim-best look (helix preset)
  {
    "folke/which-key.nvim",
    opts = {
      preset = "helix",
      icons = {
        group = "+ ",
      },
    },
    event = "VeryLazy",
  },

  -- Plugins referenced by core/keymaps.lua
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "mcauley-penney/tidy.nvim",
    config = true,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = {
      { "echasnovski/mini.icons", opts = {} },
    },
    lazy = false,
  },
  {
    "tomasky/bookmarks.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("bookmarks")
      require("bookmarks").setup({
        keywords = {
          ["@x"] = "*",
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      graph_style = "kitty",
      disable_line_numbers = false,
      integrations = {
        telescope = true,
        diffview = true,
      },
      sections = {
        untracked = {
          folded = false,
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      presets = {
        lsp_doc_border = true,
        long_message_to_split = true,
        inc_rename = true,
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        ["vim.lsp.util.stylize_markdown"] = false,
        ["cmp.entry.get_documentation"] = false,
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {},
  },
}
