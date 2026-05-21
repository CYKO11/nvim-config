return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					typescript = { "prettier" },
					svelte = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					json = { "prettier" },
					markdown = { "prettier" },
					c = { "prettier" },
					lua = { "stylua" },
				},
				format_on_save = true, -- Disable auto-format on save
				formatters = {
					prettier = {
						command = function(_, ctx)
							local local_bin = vim.fs.find("node_modules/.bin/prettier", {
								upward = true,
								path = vim.fs.dirname(ctx.filename),
								type = "file",
							})[1]
							return local_bin or "prettier"
						end,
						prepend_args = function(_, ctx)
							local args = { "--tab-width", "2" }
							local local_bin = vim.fs.find("node_modules/.bin/prettier", {
								upward = true,
								path = vim.fs.dirname(ctx.filename),
								type = "file",
							})[1]
							if local_bin then
								local project_root = vim.fs.dirname(vim.fs.dirname(vim.fs.dirname(local_bin)))
								local pkg = project_root .. "/node_modules/prettier/package.json"
								local major = 3
								local f = io.open(pkg, "r")
								if f then
									local content = f:read("*a")
									f:close()
									local v = content:match('"version"%s*:%s*"(%d+)')
									if v then
										major = tonumber(v)
									end
								end
								if major < 3 then
									table.insert(args, "--plugin-search-dir")
									table.insert(args, project_root)
								end
							elseif ctx.filename:match("%.svelte$") then
								local plugin = vim.fn.expand("~/.npm-global/lib/node_modules/prettier-plugin-svelte/plugin.js")
								if vim.fn.filereadable(plugin) == 1 then
									table.insert(args, "--plugin")
									table.insert(args, plugin)
								end
							end
							return args
						end,
						timeout_ms = 10000,
					},
				},
			})
		end,
	},
}
