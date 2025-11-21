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

-- Copy to system clipboard with Ctrl+c
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { silent = true, desc = "Copy line to clipboard" })

-- Paste from system clipboard with Ctrl+v
vim.keymap.set("n", "<leader>p", '"+p', { silent = true, desc = "Paste from clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { silent = true, desc = "Paste from clipboard" })

-- Select current word with leader+w
vim.keymap.set("n", "<leader>w", "viw", { silent = true, desc = "Select current word" })

-- Set marker with leader+m and return to it with leader+b
vim.keymap.set("n", "<leader>m", "mM", { silent = true, desc = "Set marker M" })
vim.keymap.set("n", "<leader>b", "`M", { silent = true, desc = "Jump to marker M" })

-- Window navigation with leader+[asd]
vim.keymap.set("n", "<leader>a", "<C-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<leader>d", "<C-w>l", { silent = true, desc = "Move to right window" })
vim.keymap.set("n", "<leader>s", "<C-w>j", { silent = true, desc = "Move to window below" })

-- Window navigation with Alt+[hjkl]
vim.keymap.set("n", "<A-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { silent = true, desc = "Move to right window" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { silent = true, desc = "Move to window above" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { silent = true, desc = "Move to window below" })

-- Search for visual selection with leader+s
vim.keymap.set("v", "<leader>s", 'y/<C-r>"<CR>', { desc = "Search for selection" })
vim.keymap.set("n", "<leader>s", 'y/<C-r>"<CR>', { desc = "Search for selection" })

-- Clear search highlights with leader+Esc
vim.keymap.set("n", "<leader><Esc>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlights" })

-- Tab navigation with Alt+[a/d]
vim.keymap.set("n", "<A-a>", ":tabprevious<CR>", { silent = true, desc = "Go to previous tab" })
vim.keymap.set("n", "<A-d>", ":tabnext<CR>", { silent = true, desc = "Go to next tab" })
vim.keymap.set("i", "<A-a>", "<Esc>:tabprevious<CR>", { silent = true, desc = "Go to previous tab" })
vim.keymap.set("i", "<A-d>", "<Esc>:tabnext<CR>", { silent = true, desc = "Go to next tab" })
vim.keymap.set("v", "<A-a>", "<Esc>:tabprevious<CR>", { silent = true, desc = "Go to previous tab" })
vim.keymap.set("v", "<A-d>", "<Esc>:tabnext<CR>", { silent = true, desc = "Go to next tab" })

-- Create new tab with Alt+Shift+N
vim.keymap.set("n", "<A-n>", ":tabnew<CR>", { silent = true, desc = "Create new tab" })

-- Navigate to specific tabs with Alt+[yuiop[]]
vim.keymap.set("n", "<A-y>", ":tabn 1<CR>", { silent = true, desc = "Go to tab 1" })
vim.keymap.set("n", "<A-u>", ":tabn 2<CR>", { silent = true, desc = "Go to tab 2" })
vim.keymap.set("n", "<A-i>", ":tabn 3<CR>", { silent = true, desc = "Go to tab 3" })
vim.keymap.set("n", "<A-o>", ":tabn 4<CR>", { silent = true, desc = "Go to tab 4" })
vim.keymap.set("n", "<A-p>", ":tabn 5<CR>", { silent = true, desc = "Go to tab 5" })
vim.keymap.set("n", "<A-[>", ":tabn 6<CR>", { silent = true, desc = "Go to tab 6" })
vim.keymap.set("n", "<A-]>", ":tabn 7<CR>", { silent = true, desc = "Go to tab 7" })

-- Open terminal with leader+t
vim.keymap.set("n", "<A-e>", ":terminal<CR>", { silent = true, desc = "Open terminal" })

-- Exit terminal mode with Alt+Esc
vim.keymap.set("t", "<A-e>", "<C-\\><C-n>", { silent = true, desc = "Exit terminal mode" })
