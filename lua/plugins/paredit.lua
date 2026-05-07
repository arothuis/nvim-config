local function lsp_indent(event, opts)
  local traversal = require("nvim-paredit.utils.traversal")
  local utils = require("nvim-paredit.indentation.utils")
  local ts_context = require("nvim-paredit.treesitter.context")

  local context = ts_context.create_context()

  local parent = event.parent

  local child
  if event.type == "slurp-forwards" then
    child = parent:named_child(parent:named_child_count() - 1)
  elseif event.type == "slurp-backwards" then
    child = parent:named_child(1)
  elseif event.type == "barf-forwards" then
    child = traversal.get_next_sibling_ignoring_comments(event.parent, context)
  elseif event.type == "barf-backwards" then
    child = event.parent
  else
    return
  end
  local child_range = { child:range() }
  local lines = utils.find_affected_lines(child, utils.get_node_line_range(child_range))

  vim.lsp.buf.format({
    bufnr = opts.buf or 0,
    range = {
      ["start"] = { lines[1] + 1, 0 },
      ["end"] = { lines[#lines] + 1, 0 },
    },
  })
end

return {
  "julienvincent/nvim-paredit",
  opts = {
    indent = {
      enabled = true,
      indentor = lsp_indent,
    },
  },
}
