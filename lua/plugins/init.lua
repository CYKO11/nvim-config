return {
	-- Import all the plugin modules
	require("plugins.sensible"),
	require("plugins.devicons"),
	require("plugins.html5"),
	require("plugins.javascript"),
	require("plugins.svelte"),
	require("plugins.telescope"),
	require("plugins.lualine"),
	require("plugins.claude"),
	require("plugins.toggleterm"),
	require("plugins.nvimtree"),
	require("plugins.indentblankline"),
	-- Load all colorschemes
	unpack(require("plugins.colorschemes")),
}
