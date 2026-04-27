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
            ["<leader>f"] = "close",
            ["<leader>g"] = "close",
          },
        },
      },
    })
    
     -- Add keybinding for Ctrl+F to open Telescope find_files
    vim.keymap.set('n', "<leader>f", '<cmd>Telescope find_files<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', "<leader>g", '<cmd>Telescope live_grep<CR>', { noremap = true, silent = true })

    -- Search grep with selected text
    vim.keymap.set('v', "<leader>g", function()
      -- Yank the visual selection to the unnamed register
      vim.cmd('normal! "vy')

      -- Get the yanked text
      local selected_text = vim.fn.getreg('v')

      -- Open Telescope live_grep with selected text as default
      require('telescope.builtin').live_grep({ default_text = selected_text })
    end, { noremap = true, silent = true })
  end
}
