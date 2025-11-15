-- Bootstrap lazy.nvim plugin manager if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

-- Configure indentation to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Set window title to current folder name
vim.opt.title = true
vim.opt.titlestring = ">> %{fnamemodify(getcwd(), ':t')} <<"

-- Load all plugins from the lua/plugins directory
require("lazy").setup("plugins")
require("tokyonight").setup({
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})

-- Color schemes should be loaded after plugins
vim.cmd("silent! colorscheme tokyonight")
-- vim.cmd("silent! colorscheme monoglow")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- require("lspconfig").vtsls.setup({})

-- Load keybindings
require("keybinds")

-- Load custom behaviours
require("behaviour")
