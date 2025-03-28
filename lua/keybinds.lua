-- Map Ctrl+S to save in normal, insert, and visual modes
vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true, desc = "Save file" })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { silent = true, desc = "Save file" })
vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>gv', { silent = true, desc = "Save file" })

-- Map Ctrl+N to toggle terminal
vim.keymap.set('n', '<C-n>', ':ToggleTerm<CR>', { silent = true, desc = "Toggle terminal" })
vim.keymap.set('i', '<C-n>', '<Esc>:ToggleTerm<CR>', { silent = true, desc = "Toggle terminal" })
vim.keymap.set('v', '<C-n>', '<Esc>:ToggleTerm<CR>', { silent = true, desc = "Toggle terminal" })

-- Map Ctrl+B to toggle nvim-tree
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { silent = true, desc = "Toggle NvimTree" })
vim.keymap.set('i', '<C-b>', '<Esc>:NvimTreeToggle<CR>', { silent = true, desc = "Toggle NvimTree" })
vim.keymap.set('v', '<C-b>', '<Esc>:NvimTreeToggle<CR>', { silent = true, desc = "Toggle NvimTree" })