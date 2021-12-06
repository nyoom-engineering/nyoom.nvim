local M = {}
local api = vim.api
local icons = require "tables._icons"
local space = " "
function M.get_file_icon()
   local file_name = api.nvim_buf_get_name(current_buf)
   if string.find(file_name, "term://") ~= nil then
      icon = " " .. api.nvim_call_function("fnamemodify", { file_name, ":p:t" })
   end
   file_name = api.nvim_call_function("fnamemodify", { file_name, ":p:t" })
   if file_name == "" then
      icon = ""
      return icon
   end
   local icon = icons.deviconTable[file_name]
   if icon ~= nil then
      return icon .. space
   else
      return ""
   end
end

return M
