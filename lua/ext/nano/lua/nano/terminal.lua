local M = {}
local p = require "nano.palette"

function M.setup()
   vim.g.terminal_color_0 = p.black
   vim.g.terminal_color_8 = p.bg2

   vim.g.terminal_color_7 = p.fg
   vim.g.terminal_color_15 = p.fg

   vim.g.terminal_color_1 = p.red
   vim.g.terminal_color_9 = p.red

   vim.g.terminal_color_2 = p.green
   vim.g.terminal_color_10 = p.green

   vim.g.terminal_color_3 = p.yellow
   vim.g.terminal_color_11 = p.yellow

   vim.g.terminal_color_4 = p.blue
   vim.g.terminal_color_12 = p.blue

   vim.g.terminal_color_5 = p.purple
   vim.g.terminal_color_13 = p.purple

   vim.g.terminal_color_6 = p.cyan
   vim.g.terminal_color_14 = p.cyan
end

return M
