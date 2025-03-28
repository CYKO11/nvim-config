return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local telescope = require('telescope')
    
    -- Configure Telescope
    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-f>"] = "close",
          },
        },
      },
    })
    
    -- Add keybinding for Ctrl+F to open Telescope find_files
    vim.keymap.set('n', '<C-f>', '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
  end
}
