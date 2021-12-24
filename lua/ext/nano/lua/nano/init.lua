local highlights = require "nano.highlights"
local terminal = require "nano.terminal"

local M = {}

function M.colorscheme()
   vim.cmd "hi clear"
   if vim.fn.exists "syntax_on" then
      vim.cmd "syntax reset"
   end
   vim.o.background = "light"
   vim.o.termguicolors = true
   vim.g.colors_name = "nano"
   highlights.setup()
   terminal.setup()

   vim.cmd [[au ColorSchemePre * lua require("nano.highlights").clear_namespace()]]
end

return M
