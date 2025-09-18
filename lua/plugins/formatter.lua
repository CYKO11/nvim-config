return {
  {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          svelte = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          json = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = false, -- Disable auto-format on save
        formatters = {
          prettier = {
            prepend_args = { "--tab-width", "2" },
          },
        },
      })
    end,
  },
}