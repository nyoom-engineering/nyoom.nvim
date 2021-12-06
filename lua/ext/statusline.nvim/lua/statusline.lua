local statusline = require "modules.statusline"
local M = {}
M.lsp_diagnostics = true -- Enable Nvim native LSP as default

-- TODO: Clean up this mess
function M.activeLine()
   if M.lsp_diagnostics == true then
      vim.wo.statusline = "%!v:lua.require'modules.statusline'.wants_lsp()"
   else
      vim.wo.statusline = "%!v:lua.require'modules.statusline'.activeLine()"
   end
end

function M.simpleLine()
   vim.wo.statusline = statusline.simpleLine()
end

function M.inActiveLine()
   vim.wo.statusline = statusline.inActiveLine()
end

return M
