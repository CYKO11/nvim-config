return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons", -- optional
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

		require("nvim-tree").setup({
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
			git = {
				ignore = false, -- If set to false, gitignored files will be shown
			},
			filters = {
				dotfiles = true, -- Show dotfiles including .env
			},
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")

				-- Default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- Custom mappings
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- Ctrl+[ to go up one directory level
				vim.keymap.set("n", "<C-[>", api.tree.change_root_to_parent, opts("Up"))

				-- Ctrl+] to enter/open directory
				-- vim.keymap.set('n', '<C-]>', api.node.open.edit, opts('Open'))
			end,
		})
	end,
}
