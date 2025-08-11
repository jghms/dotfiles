local filetypes = require('utils.filetypes')

return function()
	local filetype = vim.bo.filetype

	if filetype == filetypes.sql then
		if vim.fn.executable("sleek") ~= 1 then
			vim.notify("sleek is not installed, skipping formatting", vim.log.levels.ERROR)
			return
		end

		local bufnr = vim.api.nvim_get_current_buf()
		local temp_file_name = vim.fn.tempname()

		vim.api.nvim_buf_call(bufnr, function()
			vim.cmd("silent noa write " .. vim.fn.fnameescape(temp_file_name))
		end)

		vim.cmd("silent !sleek " .. vim.fn.fnameescape(temp_file_name))

		local temp_file = io.open(temp_file_name, "r")

		if temp_file == nil then
			vim.notify_once("Failed to read formatted file", vim.log.levels.ERROR)

			return
		end

		local temp_content = temp_file:read("*all")
		local formatted = vim.split(temp_content, " ")
		formatted = vim.split(temp_content, "\n")

		temp_file:close()

		os.remove(temp_file_name)

		vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)

		return
	end

	vim.lsp.buf.format()
end
