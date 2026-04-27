-- VSCode-compatible keybindings
-- These are keybinds from the main config that work well with VSCode Neovim extension

-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Map leader+q to Escape (works in VSCode)
vim.keymap.set("i", "<leader>q", "<Esc>", { silent = true, desc = "Exit insert mode" })
vim.keymap.set("v", "<leader>q", "<Esc>", { silent = true, desc = "Exit visual mode" })

-- Copy to system clipboard with leader+y
vim.keymap.set("v", "<leader>y", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { silent = true, desc = "Copy line to clipboard" })

-- Paste from system clipboard with leader+p
vim.keymap.set("n", "<leader>p", '"+p', { silent = true, desc = "Paste from clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { silent = true, desc = "Paste from clipboard" })

-- Select current word with leader+w
vim.keymap.set("n", "<leader>w", "viw", { silent = true, desc = "Select current word" })

-- Set marker with leader+m and return to it with leader+b
vim.keymap.set("n", "<leader>m", "mM", { silent = true, desc = "Set marker M" })
vim.keymap.set("n", "<leader>b", "`M", { silent = true, desc = "Jump to marker M" })

-- Window/Split navigation with leader+[asd]
-- In VSCode these work for navigating between editor groups
vim.keymap.set("n", "<leader>a", "<C-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<leader>d", "<C-w>l", { silent = true, desc = "Move to right window" })
vim.keymap.set("n", "<leader>s", "<C-w>j", { silent = true, desc = "Move to window below" })

-- Window navigation with Alt+[hjkl]
vim.keymap.set("n", "<A-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { silent = true, desc = "Move to right window" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { silent = true, desc = "Move to window above" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { silent = true, desc = "Move to window below" })

-- Clear search highlights with leader+Esc
vim.keymap.set("n", "<leader><Esc>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlights" })

-- VSCode-specific keybinds using VSCode commands
if vim.g.vscode then
	local vscode = require("vscode-neovim")

	-- Format code with leader+i (uses VSCode's format command)
	vim.keymap.set("n", "<leader>i", function()
		vscode.call("editor.action.formatDocument")
	end, { silent = true, desc = "Format code" })
	vim.keymap.set("v", "<leader>i", function()
		vscode.call("editor.action.formatSelection")
	end, { silent = true, desc = "Format selection" })

	-- Toggle comment with leader+/ (uses VSCode's comment command)
	vim.keymap.set("n", "<leader>/", function()
		vscode.call("editor.action.commentLine")
	end, { silent = true, desc = "Toggle comment" })
	vim.keymap.set("v", "<leader>/", function()
		vscode.call("editor.action.commentLine")
	end, { silent = true, desc = "Toggle comment" })

	-- File explorer with leader+e (uses VSCode's explorer)
	-- vim.keymap.set("n", "<leader>e", function()
	-- 	vscode.call("workbench.view.explorer")
	-- end, { silent = true, desc = "Toggle Explorer" })

	-- Tab navigation with Alt+[a/d]
	vim.keymap.set("n", "<A-a>", function()
		vscode.call("workbench.action.previousEditor")
	end, { silent = true, desc = "Go to previous tab" })
	vim.keymap.set("n", "<A-d>", function()
		vscode.call("workbench.action.nextEditor")
	end, { silent = true, desc = "Go to next tab" })

	-- Create new tab with Alt+n
	vim.keymap.set("n", "<A-n>", function()
		vscode.call("workbench.action.files.newUntitledFile")
	end, { silent = true, desc = "Create new file" })

	-- Navigate to specific editor groups (VSCode tabs)
	for i = 1, 7 do
		local keys = { "y", "u", "i", "o", "p", "[", "]" }
		vim.keymap.set("n", "<A-" .. keys[i] .. ">", function()
			vscode.call("workbench.action.openEditorAtIndex" .. i)
		end, { silent = true, desc = "Go to tab " .. i })
	end

	-- Quick open with leader+f
	vim.keymap.set("n", "<leader>f", function()
		vscode.call("workbench.action.quickOpen")
	end, { silent = true, desc = "Quick open" })

	-- Command palette with leader+p (alternative binding)
	vim.keymap.set("n", "<leader>P", function()
		vscode.call("workbench.action.showCommands")
	end, { silent = true, desc = "Command palette" })
end
