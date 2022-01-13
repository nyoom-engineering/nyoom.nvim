modes = setmetatable({
   ["n"] = "NORMAL",
   ["no"] = "NORMAL·P",
   ["v"] = "VISUAL",
   ["V"] = "VISUAL·L",
   [""] = "VISUAL·B", -- this is not ^V, but it's , they're different
   ["s"] = "S",
   ["S"] = "S·L",
   [""] = "S·B", -- same with this one, it's not ^S but it's 
   ["i"] = "INSERT",
   ["ic"] = "INSERT",
   ["R"] = "REPLACE",
   ["Rv"] = "V·REPLACE",
   ["c"] = "COMMAND",
   ["cv"] = "COMMAND·V·E",
   ["ce"] = "COMMAND·E",
   ["r"] = "P",
   ["rm"] = "RM",
   ["r?"] = "C",
   ["!"] = "S",
   ["t"] = "T",
}, {
   __index = function()
      return "U" -- handle edge cases
   end,
})

function get_current_mode()
   local current_mode = vim.api.nvim_get_mode().mode
   return string.format(" %s ", modes[current_mode]):upper()
end

function get_git_status()
   local branch = vim.b.gitsigns_status_dict or { head = "" }
   local is_head_empty = branch.head ~= ""
   return is_head_empty and string.format(" (#%s) ", branch.head or "") or ""
end

function get_filename()
   local filename = vim.fn.expand "%:t"
   return filename == "" and "" or filename
end

function get_line_col()
   return "%l:%c"
end

function space()
   return " "
end

function status_line()
   return table.concat {
      "%#StatusLineAccent#",
      get_current_mode(),
      "%#StatusLine#",
      space(),
      get_filename(),
      "%#StatusLineDull#",
      get_git_status(),
      "%=",
      get_line_col(),
   }
end

local M = {}
function M.setup()
   vim.o.statusline = "%!luaeval('status_line()')"
end
return M
