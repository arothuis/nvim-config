-- General config
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.number = true
vim.opt.relativenumber = true

vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

vim.opt.colorcolumn = "80"

vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.wrap = false
vim.opt.breakindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'

-- Timings
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Yank to clipboard
vim.opt.clipboard:append 'unnamedplus'

-- Auto commands
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Terminal
vim.keymap.set("t", "<C-q>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Plugins and settings
require("core.lazy")
require("core.lsp")
require("core.keymaps")
