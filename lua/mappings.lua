-- We deliberately do NOT `require("nvchad.mappings")` here — its <leader>
-- bindings clash with the nvim-best groups (<leader>h, <leader>b, <leader>x).
-- The non-leader bits we want from NvChad are reproduced below; the leader
-- bindings are defined (regrouped & rephrased) in core/keymaps.lua.

local map = vim.keymap.set

-- Editor
map("n", ";", ":", { desc = "Enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "Yank whole file" })

-- File tree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Buffers (tabufline)
map("n", "<tab>", function() require("nvchad.tabufline").next() end, { desc = "Next buffer" })
map("n", "<S-tab>", function() require("nvchad.tabufline").prev() end, { desc = "Previous buffer" })

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Exit terminal mode" })
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "Toggle vertical terminal" })
map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "Toggle horizontal terminal" })
map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "Toggle floating terminal" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Load grouped which-key keymaps
local ok, err = pcall(require, "core.keymaps")
if not ok then
  vim.notify("core.keymaps failed to load: " .. tostring(err), vim.log.levels.WARN)
end
