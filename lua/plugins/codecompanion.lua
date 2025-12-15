-- TODO: Use external environment variable for API key
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
      cmd = {
        adapter = "gemini",
      }
    },
    adapters = {
      http = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            schema = {
              model = {
                default = "gemini-2.5-flash-lite",
              },
            },
            optional = {
              generationConfig = {
                temperature = 0.2,
                maxOutputTokens = 1024,
              }
            }
          })
        end,
        opts = {
          agents = { enable = true },
        }
      },
    },
  }
}
