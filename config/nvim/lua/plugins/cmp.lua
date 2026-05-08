return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			mapping = cmp.mapping.preset.insert(),
			sources = { { name = "nvim_lsp" } },
		})
	end,
}
