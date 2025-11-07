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
    vim.keymap.set('v', "<leader>G", function()
      -- Get the visual selection
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local lines = vim.fn.getline(start_pos[2], end_pos[2])

      -- Handle single line selection
      if #lines == 1 then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
      else
        -- Handle multi-line selection
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
      end

      local selected_text = table.concat(lines, "\n")

      -- Open Telescope live_grep with selected text as default
      require('telescope.builtin').live_grep({ default_text = selected_text })
    end, { noremap = true, silent = true })
  end
}
