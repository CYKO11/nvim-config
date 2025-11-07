return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	opts = {
		presets = {
			command_palette = true, -- center the command line
			bottom_search = false, -- disable bottom search
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = true,
		},
	},
}
