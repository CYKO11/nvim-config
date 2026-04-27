return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      direction = "float", -- popup window!
      float_opts = {
        border = "curved", -- like Telescope
      }
    })
  end
}
