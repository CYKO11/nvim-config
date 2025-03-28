-- Custom behaviours for Neovim

-- Enable line wrapping with visual indentation
vim.opt.wrap = true
vim.opt.breakindent = true

-- Auto-update plugins when changing directory
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    -- Update working directory for nvim-tree if loaded
    if package.loaded["nvim-tree"] then
      require("nvim-tree.api").tree.change_root(vim.fn.getcwd())
    end
    
    -- You can add other plugins that need directory updates here
  end,
})

-- Auto-equalize window sizes when Vim is resized
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "tabdo windo wincmd =",
})