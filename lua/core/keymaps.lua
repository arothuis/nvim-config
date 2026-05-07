local paredit = require("nvim-paredit")
local which_key = require("which-key")
local telescope = require("telescope.builtin")
local flash = require("flash")
local tidy = require("tidy")
local oil = require("oil")
local gitsigns = require("gitsigns")
local lspmark = require("lspmark.bookmarks")

which_key.add({
  -- Global
  {
    { "g",        group = "g commands" },
    { "gd",       vim.lsp.buf.definition,      desc = "Go to definition" },
    { "gD",       vim.lsp.buf.declaration,     desc = "Go to declaration" },
    { "gO",       vim.lsp.buf.document_symbol, desc = "Document symbols" },
    { "gr",       group = "LSP" },
    { "gra",      vim.lsp.buf.code_action,     desc = "Code action" },
    { "gri",      vim.lsp.buf.implementation,  desc = "Implementation" },
    { "grn",      vim.lsp.buf.rename,          desc = "Rename" },
    { "grr",      vim.lsp.buf.references,      desc = "References" },
    { "grt",      vim.lsp.buf.type_definition, desc = "Type definition" },
    { "grh",      vim.lsp.buf.signature_help,  desc = "Signature help" },
    { "z",        group = "z commands" },
    { "[",        group = "[ commands" },
    { "]",        group = "] commands" },
    { "<esc>",    "<CMD>:nohlsearch<CR>",      desc = "Clear highlights" },
    { "<A-o>",    "o<Esc>",                    desc = "Insert newline after this line",  mode = "n" },
    { "<A-O>",    "O<Esc>",                    desc = "Insert newline before this line", mode = "n" },
    { "<leader>", group = "Leader" },
  },
  -- Help
  {
    { "<leader>h",  group = "Help" },
    { "<leader>hk", which_key.show,      desc = "Show keymaps" },
    { "<leader>ht", "<CMD>:Themify<CR>", desc = "Show themes" },
    { "<leader>hl", "<CMD>:Mason<CR>",   desc = "Show language tools" }
  },
  -- Search
  {
    { "<leader>s",  group = "Search" },
    {
      "<leader>sf",
      function()
        telescope.find_files({ no_ignore = false, hidden = true })
      end,
      desc = "Search file"
    },
    { "<leader>si", telescope.lsp_implementations,       desc = "Search implementations" },
    { "<leader>sr", telescope.lsp_references,            desc = "Show references" },
    { "<leader>st", telescope.lsp_type_definition,       desc = "Show type definition" },
    { "<leader>sh", vim.lsp.buf.signature_help,          desc = "Show signature help" },
    { "<leader>so", telescope.oldfiles,                  desc = "Search old file" },
    { "<leader>st", telescope.current_buffer_fuzzy_find, desc = "Search in this buffer" },
    { "<leader>sd", telescope.commands,                  desc = "Search commands" },
    { "<leader>sc", telescope.grep_string,               desc = "Search cursor grep" },
    { "<leader>sw", telescope.live_grep,                 desc = "Search live grep" },
    { "<leader>sg", telescope.live_grep,                 desc = "Search live grep" },
    { "<leader>sb", telescope.buffers,                   desc = "Search buffer" },
    { "<leader>sh", telescope.help_tags,                 desc = "Search help tags" },
    { "<leader>sk", telescope.keymaps,                   desc = "Search keymaps" },
    { "<leader>ss", telescope.lsp_workspace_symbols,     desc = "Search workspace symbols " },
    { "<leader>sT", "<cmd>TodoTelescope<cr>",            desc = "Search todo comments" },
    { "<leader>sx", telescope.resume,                    desc = "Search continued..." },
  },
  -- Flash (cursor jumping)
  {
    { "s", flash.jump,       desc = "Jump cursor (Flash)" },
    { "S", flash.treesitter, desc = "Select with treesitter (Flash)" },
  },
  -- Files
  {
    { "<leader>f",  group = "Files" },
    { "<leader>ff", telescope.find_files, desc = "Find file" },
    { "<leader>fo", oil.open,             desc = "Explore workspace (Oil)" },
    {
      "<leader>fc",
      function()
        oil.open(vim.fn.stdpath("config"))
      end,
      desc = "Explore configuration (Oil)"
    },
    {
      "<leader>fh",
      function()
        oil.open("~")
      end,
      desc = "Explore home (Oil)"
    },
    {
      "<leader>fk",
      function()
        oil.open(vim.fn.stdpath("config") .. "/" .. "lua/core/keymaps.lua")
      end,
      desc = "Open keymaps file (Oil)"
    },
    {
      "<leader>fh",
      function()
        oil.open("~")
      end,
      desc = "Explore home directory (Oil)"
    },
    { "<leader>o", oil.open, desc = "Explore workspace (Oil)" }
  },
  -- Code
  {
    mode = { "v", "n" },
    { "<leader>c",  group = "Code" },
    { "<leader>cr", vim.lsp.buf.rename,      desc = "Rename" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
    { "<leader>cs", group = "Show" },
    {
      "<leader>css",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Show document symbols",
    },
    {
      "<leader>csS",
      desc = "Show workspace symbols (Telescope)",
      telescope.lsp_workspace_symbols
    },
    {
      "<leader>csl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "Show LSP overview (Trouble)"
    },
    {
      "<leader>csd",
      "<cmd>Trouble lsp_definitions toggle focus=false win.position=right<cr>",
      desc = "Show definitions (Trouble)"
    },
    {
      "<leader>csD",
      "<cmd>Trouble lsp_declarations toggle focus=false win.position=right<cr>",
      desc = "Show declarations (Trouble)"
    },
    {
      "<leader>csi",
      "<cmd>Trouble lsp_implementations toggle focus=false win.position=right<cr>",
      desc = "Show implementations (Trouble)"
    },
    {
      "<leader>csc",
      "<cmd>Trouble lsp_incoming_calls toggle focus=false win.position=right<cr>",
      desc = "Show incoming calls (Trouble)"
    },
    {
      "<leader>csC",
      "<cmd>Trouble lsp_outgoing_calls toggle focus=false win.position=right<cr>",
      desc = "Show outgoing calls (Trouble)"
    },
    {
      "<leader>csr",
      "<cmd>Trouble lsp_references toggle focus=false win.position=right<cr>",
      desc = "Show references (Trouble)"
    },
    {
      "<leader>cst",
      "<cmd>Trouble lsp_type_definitions toggle focus=false win.position=right<cr>",
      desc = "Show type definitions (Trouble)"
    },
    { "<leader>cc",  vim.lsp.buf.signature_help,                                      desc = "Show signature help" },
    { "<leader>cb",  group = "Base64" },
    { "<leader>cbe", "c<c-r>=trim(system('base64 --wrap=0', @\"))<cr><esc>",          desc = "Base64 encode" },
    { "<leader>cbd", "c<c-r>=trim(system('base64 --wrap=0 --decode', @\"))<cr><esc>", desc = "Base64 decode" },

    -- See also: LSP-config, LSP-specific config and local leader
  },
  -- Git
  {
    { "<leader>g",   group = "Git",       mode = { "n", "v" } },
    { "<leader>gg",  "<cmd>Neogit<cr>" },
    { "<leader>gh",  group = "Hunk",      mode = { "n", "v" } },
    { "<leader>ghs", gitsigns.stage_hunk, desc = "Stage / unstage hunk" },
    { "<leader>ghr", gitsigns.reset_hunk, desc = "Reset hunk" },
    {
      "<leader>ghs",
      function()
        gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      desc = "Stage / unstage part of hunk",
      mode = { "v" }
    },
    {
      "<leader>ghr",
      function()
        gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      desc = "Reset part of hunk",
      mode = { "v" }
    },
    { "<leader>gs",  group = "Show",               mode = { "n", "v" } },
    { "<leader>gsc", telescope.git_bcommits,       desc = "Git show buffer commits" },
    { "<leader>gsc", telescope.git_bcommits_range, desc = "Git show buffer commits", mode = { "v" } },
    { "<leader>gsC", telescope.git_commits,        desc = "Git show commits" },
    { "<leader>gss", telescope.git_status,         desc = "Git show file status" },
    { "<leader>ghp", gitsigns.preview_hunk,        desc = "Preview hunk" },
    { "<leader>ghi", gitsigns.preview_hunk_inline, desc = "Preview hunk inline" },
    { "<leader>ghS", gitsigns.select_hunk,         desc = "Select hunk" },
    {
      "<leader>gB",
      function()
        gitsigns.blame_line({ full = true })
      end,
      desc = "Blame line"
    },
    { "<leader>gd",  gitsigns.diffthis,                  desc = "Diff this" },
    { "<leader>gb",  group = "Buffer" },
    { "<leader>gbs", gitsigns.stage_buffer,              desc = "Stage buffer" },
    { "<leader>gbr", gitsigns.reset_buffer,              desc = "Reset buffer" },
    { "<leader>gt",  group = "Toggle" },
    { "<leader>gtb", gitsigns.toggle_current_line_blame, desc = "Toggle current line blame" },
    { "<leader>gtw", gitsigns.toggle_word_diff,          desc = "Toggle word diff" },
    {
      "[h",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "[h", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end,
      desc = "Previous hunk"
    },
    {
      "]h",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end,
      desc = "Next hunk"
    },
  },
  -- Trouble
  {
    { "<leader>x", group = "Trouble lists" },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
    {
      "<leader>xt",
      "<cmd>TodoQuickFix<cr>",
      desc = "Todo QuickFix",
    },
    {
      "<leader>xT",
      "<cmd>Trouble todo toggle<cr>",
      desc = "Todo QuickFix (Trouble)",
    }
  },
  -- Windows
  {
    {
      "<leader>w",
      group = "Windows",
      proxy = "<c-w>",
      expand = function()
        return require("which-key.extras").expand.win()
      end,
    },
    { "<c-h>",     "<c-w>h",                      desc = "Window move left" },
    { "<c-j>",     "<c-w>j",                      desc = "Window move down" },
    { "<c-k>",     "<c-w>k",                      desc = "Window move up" },
    { "<c-l>",     "<c-w>l",                      desc = "Window move right" },
    { "<c-left>",  "<cmd>vertical resize -3<cr>", desc = "Shrink vertical window" },
    { "<c-down>",  "<cmd>resize -3<cr>",          desc = "Shrink horizontal window" },
    { "<c-up>",    "<cmd>resize +3<cr>",          desc = "Grow horizontal window" },
    { "<c-right>", "<cmd>vertical resize +3<cr>", desc = "Grow vertical window" },
  },
  -- Buffers
  {
    {
      "<leader>b",
      group = "Buffers",
      expand = function()
        return require("which-key.extras").expand.buf()
      end
    },
    { "<leader>bn",       "<cmd>enew<cr>",          desc = "New buffer" },
    { "<leader>br",       "<cmd>edit!<cr>",         desc = "Reload buffer" },
    { "<leader>bR",       "<cmd>buffdo edit!</cr>", desc = "Reload all buffers" },
    { "<leader>bb",       telescope.buffers,        desc = "Search buffer" },
    { "<leader><leader>", telescope.buffers,        desc = "Search buffer" },
    { "<leader>bc",       "<cmd>bdelete!<cr>",      desc = "Close current buffer" },
    { "<leader>bC",       "<cmd>%bd<cr>",           desc = "Close all buffers" },
    { "<leader>bx",       "<cmd>%bd|e#<cr>",        desc = "Close all other buffers" },
  },
  -- Bookmarks
  {
    { "<leader>m",  group = "Bookmarks" },
    {
      "<leader>mm",
      function()
        lspmark.toggle_bookmark({ with_comment = false })
      end,
      desc = "Bookmark line"
    },
    {
      "<c-b>",
      function()
        lspmark.toggle_bookmark({ with_comment = false })
      end,
      desc = "Bookmark line"
    },
    {
      "<leader>mc",
      function()
        lspmark.toggle_bookmark({ with_comment = true })
      end,
      desc = "Bookmark line with comment"
    },
    {
      "<c-s-b>",
      function()
        lspmark.toggle_bookmark({ with_comment = true })
      end,
      desc = "Bookmark line with comment"
    },
    { "<leader>ml", "<CMD>:Telescope lspmark<CR>", desc = "List bookmarks" },
  },
  -- UI/UX
  {
    { "<leader>u",  group = "User interface" },
    { "<leader>ut", "<CMD>:Themify<CR>",               desc = "Show Themify manager" },
    { "<leader>uT", "<CMD>:Telescope colorscheme<CR>", desc = "Pick colorscheme (Telescope)" },
    {
      "<leader>un",
      function()
        vim.wo.relativenumber = not vim.wo.relativenumber
      end,
      desc = "Toggle relative line numbers"
    },
    { "<leader>ud", "<CMD>:Twilight<CR>", desc = "Toggle dimming" },
    { "<leader>uz", "<CMD>:ZenMode<CR>",  desc = "Toggle Zen Mode" },
    {
      "<leader>uc",
      function()
        local ccs = vim.opt_local.colorcolumn:get()

        local nums = {}
        for _, v in ipairs(ccs) do
          table.insert(nums, tonumber(v))
        end

        if vim.tbl_contains(nums, 80) then
          vim.opt_local.colorcolumn = {}
        else
          vim.opt_local.colorcolumn = { "80" }
        end
      end,
      desc = "Toggle character limit column",
    }
  },
  -- AI / Claude Code
  {
    { "<leader>a",  group = "AI (Claude Code)" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude session" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue last Claude session" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer to Claude" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept Claude diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Reject Claude diff" },
    { "<leader>a",  group = "AI (Claude Code)",       mode = "v" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "Send selection to Claude", mode = "v" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer to Claude", mode = "v" },
  },
  -- Localleader
  {
    {
      "<localleader>w",
      function()
        paredit.cursor.place_cursor(
          paredit.wrap.wrap_element_under_cursor("( ", ")"),
          { placement = "inner_start", mode = "insert" }
        )
      end,
      desc = "Wrap element insert head"
    },
    {
      "<localleader>W",
      function()
        paredit.cursor.place_cursor(
          paredit.wrap.wrap_element_under_cursor("( ", ")"),
          { placement = "inner_end", mode = "insert" }
        )
      end,
      desc = "Wrap element insert tail"
    },
    {
      "<localleader>i",
      function()
        paredit.cursor.place_cursor(
          paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"),
          { placement = "inner_start", mode = "insert" }
        )
      end,
      desc = "Wrap form insert tail"
    },
    {
      "<localleader>W",
      function()
        paredit.cursor.place_cursor(
          paredit.wrap.wrap_enclosing_form_under_cursor("( ", ")"),
          { placement = "inner_end", mode = "insert" }
        )
      end,
      desc = "Wrap form insert tail"
    },

  },
})
