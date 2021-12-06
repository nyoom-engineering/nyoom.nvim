local M = {}
-- local vim = vim
function M.editable()
   if vim.bo.filetype == "help" then
      return ""
   end
   if vim.bo.readonly == true then
      return " "
   end
   return ""
end
return M
