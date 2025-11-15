-- Set tab as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map leader+q to Escape
vim.keymap.set("i", "<leader>q", "<Esc>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("v", "<leader>q", "<Esc>", { silent = true, desc = "Exit visual mode" })

-- Map Ctrl+S to save in normal, insert, and visual modes
-- vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true, desc = "Save file" })
-- vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { silent = true, desc = "Save file" })
-- vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>gv', { silent = true, desc = "Save file" })

-- Map space+e to toggle nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })

-- Format code with leader+i
vim.keymap.set("n", "<leader>i", function()
	require("conform").format({ lsp_fallback = true })
end, { silent = true, desc = "Format code" })
vim.keymap.set("v", "<leader>i", function()
	require("conform").format({ lsp_fallback = true })
end, { silent = true, desc = "Format code" })

-- Toggle comment with leader+/
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { silent = true, desc = "Toggle comment" })
vim.keymap.set("v", "<leader>/", function()
	local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { silent = true, desc = "Toggle comment" })

-- Copy to system clipboard with leader+c
vim.keymap.set("v", "<leader>c", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>c", '"+yy', { silent = true, desc = "Copy line to clipboard" })

-- Paste from system clipboard with leader+v
vim.keymap.set("n", "<leader>v", '"+p', { silent = true, desc = "Paste from clipboard" })
vim.keymap.set("v", "<leader>v", '"+p', { silent = true, desc = "Paste from clipboard" })

-- Window navigation with leader+[wasd]
vim.keymap.set("n", "<leader>a", "<C-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<leader>d", "<C-w>l", { silent = true, desc = "Move to right window" })
vim.keymap.set("n", "<leader>w", "<C-w>k", { silent = true, desc = "Move to window above" })

-- Search for visual selection with leader+s
vim.keymap.set("v", "<leader>s", 'y/<C-r>"<CR>', { desc = "Search for selection" })
vim.keymap.set("n", "<leader>s", 'y/<C-r>"<CR>', { desc = "Search for selection" })

-- Clear search highlights with leader+Esc
vim.keymap.set("n", "<leader><Esc>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlights" })

-- Tab navigation with Alt+Shift+[A/D]
vim.keymap.set("n", "<A-h>", ":tabprevious<CR>", { silent = true, desc = "Go to previous tab" })
vim.keymap.set("n", "<A-l>", ":tabnext<CR>", { silent = true, desc = "Go to next tab" })

-- Create new tab with Alt+Shift+N
vim.keymap.set("n", "<A-S-n>", ":tabnew<CR>", { silent = true, desc = "Create new tab" })
