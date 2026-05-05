return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local screen_w = vim.opt.columns:get()
		local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
		local w = math.floor(screen_w * 0.8)
		local h = math.floor(screen_h * 0.8)
		local col = (screen_w - w) / 2
		local row = ((vim.opt.lines:get() - h) / 2) - vim.opt.cmdheight:get()

		local shared = {
			git = { ignore = false },
			on_attach = function(bufnr)
				local api = require("nvim-tree.api")
				api.config.mappings.default_on_attach(bufnr)
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end
				vim.keymap.set("n", "<C-[>", api.tree.change_root_to_parent, opts("Up"))
			end,
		}

		local float_config = vim.tbl_deep_extend("force", shared, {
			view = {
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = w,
						height = h,
						row = row,
						col = col,
					},
				},
			},
		})

		local side_config = vim.tbl_deep_extend("force", shared, {
			view = {
				float = { enable = false },
				width = 35,
				side = "left",
			},
		})

		-- Start with float as default (preserves existing leader+e behavior)
		require("nvim-tree").setup(float_config)

		local current_mode = "float"

		local function toggle_as(mode)
			local api = require("nvim-tree.api")
			local visible = api.tree.is_visible()

			if visible and current_mode == mode then
				api.tree.close()
				return
			end

			if visible then
				api.tree.close()
			end

			if mode == "float" then
				require("nvim-tree").setup(float_config)
				current_mode = "float"
			else
				require("nvim-tree").setup(side_config)
				current_mode = "side"
			end

			api.tree.open()
		end

		vim.keymap.set("n", "<leader>e", function() toggle_as("float") end, { silent = true, desc = "Toggle NvimTree (float)" })
		vim.keymap.set("n", "<leader>t", function() toggle_as("side") end, { silent = true, desc = "Toggle NvimTree (side)" })
	end,
}
