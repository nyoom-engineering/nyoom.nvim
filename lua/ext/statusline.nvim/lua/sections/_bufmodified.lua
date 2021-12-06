local bufname = require "sections._bufname"
local space = " "
local M = {}
function M.is_buffer_modified()
   local file = bufname.get_buffer_name()
   if file == " startify " then
      return ""
   end -- exception check
   if vim.bo.modifiable and vim.bo.modified then
      return "+" .. space
   end
   return ""
end
return M
