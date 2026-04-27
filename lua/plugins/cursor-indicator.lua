-- Cursor Position Indicator Plugin
-- Shows a blinking red triangle on the left side that follows the cursor position

local M = {}

-- Blink state
local blink_visible = true
local blink_timer = nil

-- Define the sign characters for the indicator
local function setup_signs()
	-- Define sign for the triangle indicator at cursor position
	vim.fn.sign_define("CursorIndicatorTriangle", { text = "▶", texthl = "CursorIndicatorHL" })
	vim.fn.sign_define("CursorIndicatorTriangleHidden", { text = " ", texthl = "Normal" })

	-- Set the highlight color to red
	vim.api.nvim_set_hl(0, "CursorIndicatorHL", { fg = "#ff0000", bold = true })
end

-- Currently placed signs (for cleanup)
local sign_group = "cursor_indicator_group"
-- Namespace for clearing old virtual text from previous versions
local ns_id_old = vim.api.nvim_create_namespace("cursor_indicator_right")

-- Update the indicator position
local function update_indicator()
	local bufnr = vim.api.nvim_get_current_buf()
	local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(bufnr)

	-- Clear previous signs
	vim.fn.sign_unplace(sign_group, { buffer = bufnr })

	-- Clear any old virtual text from previous versions (right side)
	vim.api.nvim_buf_clear_namespace(bufnr, ns_id_old, 0, -1)

	-- Place triangle sign at cursor line (only if line is valid)
	if cursor_line > 0 and cursor_line <= total_lines then
		local sign_name = blink_visible and "CursorIndicatorTriangle" or "CursorIndicatorTriangleHidden"
		vim.fn.sign_place(0, sign_group, sign_name, bufnr, {
			lnum = cursor_line,
			priority = 10,
		})
	end
end

-- Start the blink timer
local function start_blink_timer()
	-- Stop existing timer if any
	if blink_timer then
		blink_timer:stop()
		blink_timer:close()
	end

	-- Create a new timer that fires every 500ms (half a second)
	blink_timer = vim.loop.new_timer()
	blink_timer:start(
		0, -- Start immediately
		500, -- Repeat every 500ms
		vim.schedule_wrap(function()
			-- Toggle blink state
			blink_visible = not blink_visible
			-- Update the indicator with new blink state
			update_indicator()
		end)
	)
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
			vim.api.nvim_buf_clear_namespace(bufnr, ns_id_old, 0, -1)
		end,
	})
end

-- Initialize the plugin
function M.setup()
	setup_signs()
	setup_autocommands()
	start_blink_timer()
	-- Show indicator immediately
	vim.defer_fn(update_indicator, 100)
end

-- Allow manual toggle on/off
function M.toggle()
	if M.enabled then
		-- Disable
		vim.api.nvim_clear_autocmds({ group = "CursorIndicator" })
		if blink_timer then
			blink_timer:stop()
			blink_timer:close()
			blink_timer = nil
		end
		local bufnr = vim.api.nvim_get_current_buf()
		vim.fn.sign_unplace(sign_group, { buffer = bufnr })
		vim.api.nvim_buf_clear_namespace(bufnr, ns_id_old, 0, -1)
		M.enabled = false
		print("Cursor indicator disabled")
	else
		-- Enable
		setup_autocommands()
		start_blink_timer()
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
