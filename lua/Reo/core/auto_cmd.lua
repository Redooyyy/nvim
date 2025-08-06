-- lua/bushra/autocmds.lua
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function()
		local name = vim.api.nvim_buf_get_name(0)
		if name:match("competitestTestCases") then
			vim.api.nvim_buf_set_name(0, "Test Cases")
		elseif name:match("competitestOutput") then
			vim.api.nvim_buf_set_name(0, "Output")
		elseif name:match("competitestExpectedOutput") then
			vim.api.nvim_buf_set_name(0, "Expected Output")
		end
	end,
})
