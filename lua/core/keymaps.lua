local which_key = require("which-key")
local telescope = require("telescope.builtin")
local flash = require("flash")
local tidy = require("tidy")
local oil = require("oil")
local gitsigns = require("gitsigns")
local lspmark = require('lspmark.bookmarks')

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
    { "<leader>s",   group = "Search" },
    { "<leader>sf",  telescope.find_files,                desc = "Search file" },
    { "<leader>so",  telescope.oldfiles,                  desc = "Search old file" },
    { "<leader>st",  telescope.current_buffer_fuzzy_find, desc = "Search in this buffer" },
    { "<leader>sd",  telescope.commands,                  desc = "Search commands" },
    { "<leader>sc",  telescope.grep_string,               desc = "Search cursor grep" },
    { "<leader>sg",  telescope.live_grep,                 desc = "Search live grep" },
    { "<leader>sb",  telescope.buffers,                   desc = "Search buffer" },
    { "<leader>sh",  telescope.help_tags,                 desc = "Search help tags" },
    { "<leader>sk",  telescope.keymaps,                   desc = "Search keymaps" },
    { "<leader>css", telescope.lsp_workspace_symbols,     desc = "Search workspace symbols " },
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
    { "<leader>o", oil.open, desc = "Explore workspace (Oil)" }
  },
  -- Code
  {
    { "<leader>c",  group = "Code" },
    { "<leader>ct", tidy.run,                desc = "Trim whitespace" },
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
    -- { "<leader>csi", telescope.lsp_implementations, desc = "Show implementations" },
    -- { "<leader>csr", telescope.lsp_references, desc = "Show references" },
    -- { "<leader>cst", telescope.lsp_type_definition, desc = "Show type definition" },
    { "<leader>csh", vim.lsp.buf.signature_help, desc = "Show signature help" },
    { "<leader>cc",  vim.lsp.buf.signature_help, desc = "Show signature help" },
    -- See LSP-specific config
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
    { "<leader>ghp", gitsigns.preview_hunk,        desc = "Preview hunk" },
    { "<leader>ghi", gitsigns.preview_hunk_inline, desc = "Preview hunk inline" },
    { "<leader>ghs", gitsigns.select_hunk,         desc = "Select hunk" },
    { "ih",          gitsigns.select_hunk,         desc = "Hunk",               mode = { "o", "x" } },
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
      end
    },
    {
      "]h",
      function()
        if vim.wo.diff then
          vim.cmd.normal({ "]h", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end
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
    { "<leader>bn",       ":enew<cr>",       desc = "New buffer" },
    { "<leader>bb",       telescope.buffers, desc = "Search buffer" },
    { "<leader><leader>", telescope.buffers, desc = "Search buffer" },
    { "<leader>bc",       ":bdelete!<cr>",   desc = "Close current buffer" },
  },
  -- Bookmarks
  {
    { "<leader>m", group = "Bookmarks" },
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
    { "<leader>ut", "<CMD>:Themify<CR>",     desc = "Show themes" },
    {
      "<leader>un",
      function()
        vim.wo.relativenumber = not vim.wo.relativenumber
      end,
      desc = "Toggle relative line numbers"
    },
  },
})
