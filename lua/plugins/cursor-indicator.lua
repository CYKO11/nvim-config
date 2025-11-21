-- Cursor Position Indicator Plugin
-- Shows a 5-line red indicator on both sides of the code window
-- that follows the cursor position

local M = {}

-- Define the sign characters for the indicator
local function setup_signs()
	-- Define signs for each position in the 5-line indicator
	vim.fn.sign_define("CursorIndicatorTop2", { text = "█", texthl = "CursorIndicatorHL" })
	vim.fn.sign_define("CursorIndicatorTop1", { text = "█", texthl = "CursorIndicatorHL" })
	vim.fn.sign_define("CursorIndicatorMid", { text = "█", texthl = "CursorIndicatorHL" })
	vim.fn.sign_define("CursorIndicatorBot1", { text = "█", texthl = "CursorIndicatorHL" })
	vim.fn.sign_define("CursorIndicatorBot2", { text = "█", texthl = "CursorIndicatorHL" })

	-- Set the highlight color to red
	vim.api.nvim_set_hl(0, "CursorIndicatorHL", { fg = "#ff0000", bold = true })
end

-- Namespace for virtual text (right side indicator)
local ns_id = vim.api.nvim_create_namespace("cursor_indicator_right")

-- Currently placed signs (for cleanup)
local placed_signs = {}
local sign_group = "cursor_indicator_group"

-- Update the indicator position
local function update_indicator()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(bufnr)

	-- Clear previous signs
	vim.fn.sign_unplace(sign_group, { buffer = bufnr })

	-- Clear previous virtual text (right side)
	vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

	-- Place signs for 5 lines centered on cursor
	local positions = {
		{ line = cursor_line - 2, sign = "CursorIndicatorTop2" },
		{ line = cursor_line - 1, sign = "CursorIndicatorTop1" },
		{ line = cursor_line, sign = "CursorIndicatorMid" },
		{ line = cursor_line + 1, sign = "CursorIndicatorBot1" },
		{ line = cursor_line + 2, sign = "CursorIndicatorBot2" },
	}

	for _, pos in ipairs(positions) do
		if pos.line > 0 and pos.line <= total_lines then
			-- Place sign on the left
			vim.fn.sign_place(0, sign_group, pos.sign, bufnr, {
				lnum = pos.line,
				priority = 10,
			})

			-- Place virtual text on the right
			local line_text = vim.api.nvim_buf_get_lines(bufnr, pos.line - 1, pos.line, false)[1] or ""
			vim.api.nvim_buf_set_extmark(bufnr, ns_id, pos.line - 1, 0, {
				virt_text = { { "█", "CursorIndicatorHL" } },
				virt_text_pos = "right_align",
				priority = 10,
			})
		end
	end
end

-- Setup autocommands to update indicator
local function setup_autocommands()
	local group = vim.api.nvim_create_augroup("CursorIndicator", { clear = true })

	-- Update on cursor movement
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = group,
		callback = update_indicator,
	})

	-- Update on buffer enter
	vim.api.nvim_create_autocmd("BufEnter", {
		group = group,
		callback = function()
			-- Small delay to ensure buffer is ready
			vim.defer_fn(update_indicator, 10)
		end,
	})

	-- Update on window scroll
	vim.api.nvim_create_autocmd("WinScrolled", {
		group = group,
		callback = update_indicator,
	})

	-- Clear indicators when leaving buffer
	vim.api.nvim_create_autocmd("BufLeave", {
		group = group,
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			vim.fn.sign_unplace(sign_group, { buffer = bufnr })
			vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
		end,
	})
end

-- Initialize the plugin
function M.setup()
	setup_signs()
	setup_autocommands()
	-- Show indicator immediately
	vim.defer_fn(update_indicator, 100)
end

-- Allow manual toggle on/off
function M.toggle()
	if M.enabled then
		-- Disable
		vim.api.nvim_clear_autocmds({ group = "CursorIndicator" })
		local bufnr = vim.api.nvim_get_current_buf()
		vim.fn.sign_unplace(sign_group, { buffer = bufnr })
		vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
		M.enabled = false
		print("Cursor indicator disabled")
	else
		-- Enable
		setup_autocommands()
		update_indicator()
		M.enabled = true
		print("Cursor indicator enabled")
	end
end

M.enabled = true

-- Auto-setup when loaded
M.setup()

-- Create a command to toggle the indicator
vim.api.nvim_create_user_command("CursorIndicatorToggle", function()
	M.toggle()
end, {})

return {}
