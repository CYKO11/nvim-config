return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    local width = 0.8
    local height = 0.8
    local screen_w = vim.opt.columns:get()
    local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
    local window_w = screen_w * width
    local window_h = screen_h * height
    local window_w_int = math.floor(window_w)
    local window_h_int = math.floor(window_h)
    local center_x = (screen_w - window_w) / 2
    local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
    
    require("nvim-tree").setup {
      view = {
        float = {
          enable = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = window_w_int,
            height = window_h_int,
            row = center_y,
            col = center_x,
          },
        },
      },
    }
    
  end
}