return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = {
        'markdown',
        'codecompanion'
      }
    },
  },
  display = {
    chat = {
      icons = {
        chat_context = "📎️",
      },
      fold_context = true,
    },
  },
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
        model = "gemini-3-flash",
        -- adapter = "gemma3",
      },
      inline = {
        -- adapter = "gemma3",
        adapter = "gemini",
        model = "gemini-3-flash",
      },
      cmd = {
        -- adapter = "gemma3",
        adapter = "gemini",
        model = "gemini-3-flash",
      }
    },
    adapters = {
      http = {
        gemma3 = function()
          return require("codecompanion.adapters").extend("openai", {
            url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
            env = {
              api_key = os.getenv("GEMINI_API_KEY"),
            },
            schema = {
              model = {
                default = "gemma-3-4b-it",
              },
              temperature = { default = 1.0 },
            },
            handlers = {
              form_parameters = function(self, params, messages)
                local openai_params = require("codecompanion.adapters.http.openai").handlers.form_parameters(self, params,
                  messages)

                openai_params.frequency_penalty = nil
                openai_params.presence_penalty = nil
                openai_params.seed = nil

                return openai_params
              end,

              form_messages = function(self, messages)
                local package = { messages = {} }
                local system_prompt = ""

                for _, msg in ipairs(messages) do
                  if msg.role == "system" then
                    system_prompt = system_prompt .. msg.content .. "\n\n"
                  end
                end

                local system_injected = false
                for _, msg in ipairs(messages) do
                  if msg.role == "user" then
                    local content = msg.content
                    if not system_injected and system_prompt ~= "" then
                      content = "INSTRUCTIONS:\n" .. system_prompt .. "QUERY:\n" .. content
                      system_injected = true
                    end
                    table.insert(package.messages, { role = "user", content = content })
                  elseif msg.role == "assistant" then
                    table.insert(package.messages, { role = "assistant", content = msg.content })
                  end
                end
                return package
              end,
            },
          })
        end,
        opts = {
          agents = { enable = true },
        }
      },
    },
  }
}
