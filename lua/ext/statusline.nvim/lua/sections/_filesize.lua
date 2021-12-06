local M = {}
local vim = vim
local space = ' '

local function file_size(file)
	local size = vim.fn.getfsize(file)
	if size == 0 or size == -1 or size == -2 then
		return ''
	end
	if size < 1024 then
		size = size .. 'B'
	elseif size < 1024 * 1024 then
		size = string.format('%d', size / 1024) .. 'KB'
	elseif size < 1024 * 1024 * 1024 then
		size = string.format('%d', size / 1024 / 1024) .. 'MB'
	else
		size = string.format('%d', size / 1024 / 1024 / 1024) .. 'GB'
	end
	return size .. space
end

function M.get_file_size()
	local file = vim.fn.expand('%:p')
	if string.len(file) == 0 then
		return ''
	end
	return file_size(file)
end

return M
