-- VSCode Neovim Configuration
-- This file is loaded when running Neovim inside VSCode

-- Only load this configuration if we're in VSCode
if not vim.g.vscode then
	return
end

-- Set leader key before loading keybinds
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Reduce timeout for better responsiveness in VSCode
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

-- Configure indentation (VSCode will override based on file type, but this is the fallback)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable relative line numbers (VSCode Neovim supports this)
vim.opt.relativenumber = true
vim.opt.number = true

-- Better search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Clipboard integration
vim.opt.clipboard = "unnamedplus"

-- Load VSCode-specific keybinds
require("vscode-keybinds")
