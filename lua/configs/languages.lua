-- Single source of truth for supported languages.
-- Adding a language here auto-installs:
--   * treesitter parsers (via nvim-treesitter ensure_installed)
--   * LSP servers (via mason-lspconfig ensure_installed + vim.lsp.enable)
--
-- LSP server names must match either nvim-lspconfig defaults OR a file at
-- `<config>/lsp/<name>.lua` for custom server settings.
local M = {}

M.languages = {
  lua        = { treesitter = { "lua", "luadoc" },                 servers = { "lua_ls" } },
  typescript = { treesitter = { "typescript", "javascript", "tsx" }, servers = { "ts_ls" } },
  clojure    = { treesitter = { "clojure" },                       servers = { "clojure_lsp" } },
  svelte     = { treesitter = { "svelte" },                        servers = { "svelte" } },
  css        = { treesitter = { "css", "scss" },                   servers = { "cssls", "css_variables", "tailwindcss" } },
  html       = { treesitter = { "html" },                          servers = {} },
  json       = { treesitter = { "json", "jsonc" },                 servers = {} },
  yaml       = { treesitter = { "yaml" },                          servers = {} },
  markdown   = { treesitter = { "markdown", "markdown_inline" },   servers = {} },
  toml       = { treesitter = { "toml" },                          servers = {} },
  docker     = { treesitter = { "dockerfile" },                    servers = {} },
  terraform  = { treesitter = { "terraform" },                     servers = {} },
  csv        = { treesitter = { "csv" },                           servers = {} },
  jinja      = { treesitter = { "jinja" },                         servers = {} },
  gleam      = { treesitter = { "gleam" },                         servers = {} },
}

local function flatten(key)
  local seen, out = {}, {}
  for _, lang in pairs(M.languages) do
    for _, v in ipairs(lang[key] or {}) do
      if not seen[v] then
        seen[v] = true
        out[#out + 1] = v
      end
    end
  end
  return out
end

function M.treesitter_parsers() return flatten("treesitter") end
function M.lsp_servers() return flatten("servers") end

return M
