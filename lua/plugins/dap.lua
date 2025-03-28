return {
  'mfussenegger/nvim-dap',
  config = function()
    -- Basic nvim-dap setup
    local dap = require('dap')
    
    -- You can add keymappings for DAP here
    vim.keymap.set('n', '<F5>', function() dap.continue() end)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end)
    vim.keymap.set('n', '<C-b>', function() dap.toggle_breakpoint() end)
  end
}