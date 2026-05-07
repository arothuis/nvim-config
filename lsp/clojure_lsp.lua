return {
  cmd = {
    "clojure-lsp",
  },
  filetypes = {
    "bb",
    "clojure",
    "clojurescript",
    "edn",
  },
  root_markers = {
    ".clj-kondo",
    "deps.edn",
    "project.clj",
    "shadow-cljs.edn",
    "nbb.edn",
    "bb.edn",
  },
  single_file_support = true,

  on_attach = function(client, bufnr)
    if client.name == "clojure_lsp" then
      local function toggle_clojure_form_comment()
        local ts_utils = require("nvim-treesitter.ts_utils")
        local node

        -- 1. Identify the node to comment
        if vim.api.nvim_get_mode().mode:match("[vV]") then
          -- In Visual Mode, get the node at the start of the selection
          local start_pos = vim.fn.getpos("v")
          -- We use (row, col) - note: getpos is 1-indexed for row/col
          node = ts_utils.get_node_at_cursor()
          -- Exit visual mode immediately so we can manipulate text safely
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
        else
          -- In Normal Mode, get node under cursor
          node = ts_utils.get_node_at_cursor()
        end

        if not node then return end

        -- 2. Define what counts as an "element" to comment out
        local target_types = {
          list_lit = true,
          vec_lit = true,
          map_lit = true,
          set_lit = true,
          list = true,
          symbol = true,
          keyword = true,
          string = true,
          number = true
        }

        -- 3. Walk up until we find a valid Clojure element
        while node do
          if target_types[node:type()] then break end
          node = node:parent()
        end

        if not node then return end

        -- 4. Apply the toggle logic
        local start_row, start_col, _, _ = node:range()
        local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]

        -- Check for #_ prefixing the node
        local prefix = line:sub(math.max(0, start_col - 1), start_col)

        if prefix == "#_" then
          -- Remove: delete 2 chars before the node start
          vim.api.nvim_buf_set_text(0, start_row, start_col - 2, start_row, start_col, {})
        else
          -- Add: insert at node start
          vim.api.nvim_buf_set_text(0, start_row, start_col, start_row, start_col, { "#_" })
        end
      end

      -- Setup the keymaps
      vim.keymap.set({ "n", "v" }, "gcf", toggle_clojure_form_comment, { desc = "Structural #_ comment" })





      vim.api.nvim_buf_create_user_command(bufnr, "CljCleanNamespace", function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1] - 1 -- convert to 0-based
        local col = cursor[2]

        local params = {
          command = "clean-ns",
          arguments = { vim.uri_from_bufnr(bufnr), row, col },
        }

        -- Logging request parameters
        -- print("CljCleanNamespace: sending workspace/executeCommand request")
        -- print("Command: " .. params.command)
        -- print("Arguments:")
        -- print(vim.inspect(params.arguments))

        -- Send request to the LSP server
        local ok, request_id = client:request(
          "workspace/executeCommand",
          params,
          function(err, result)
            -- Log response
            if err then
              print("CljCleanNamespace: ERROR received from server")
              print(vim.inspect(err))
            else
              -- print(vim.inspect(result))
              local clients = vim.lsp.get_clients({ bufnr = bufnr })
              local formatted = false

              for _, c in ipairs(clients) do
                if c.server_capabilities.documentFormattingProvider then
                  vim.lsp.buf.format({ async = true })
                  formatted = true
                  break
                end
              end

              if not formatted then
                print("CljCleanNamespace: no attached LSP supports formatting")
              end
            end
          end,
          bufnr
        )

        if not ok then
          print("CljCleanNamespace: request failed to send (client may have shut down)")
        else
          print("CljCleanNamespace: request sent successfully, id = " .. request_id)
        end
      end, { desc = "Clojure: Clean namespace with clojure-lsp (DEBUG)" })
    end
  end,
}
