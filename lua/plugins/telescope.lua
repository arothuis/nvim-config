return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local make_entry = require("telescope.make_entry")

    -- vimgrep-style entry maker that hides the trailing matched-line text;
    -- preview pane still shows the full line in context.
    local function gen_grep_no_text(opts)
      local base = make_entry.gen_from_vimgrep(opts)
      return function(line)
        local entry = base(line)
        if entry then
          local prev = entry.display
          entry.display = function(e)
            local d, hl = prev(e)
            -- strip everything after the last `:N:N:` separator
            d = d:gsub(":%d+:%d+:.*$", "")
            return d, hl
          end
        end
        return entry
      end
    end

    telescope.setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            mirror = false,           -- preview on top, results below
            prompt_position = "bottom",
            preview_cutoff = 0,       -- never hide preview
          },
        },
        sorting_strategy = "ascending", -- results listed top→bottom toward prompt
        path_display = {
          filename_first = { reverse_directories = false },
        },
      },
      pickers = {
        -- Hide the inline matched-line text; preview pane shows the line.
        live_grep   = { entry_maker = gen_grep_no_text({}) },
        grep_string = { entry_maker = gen_grep_no_text({}) },
      },
    })
    telescope.load_extension("ui-select")
    telescope.load_extension("noice")
  end,
}
