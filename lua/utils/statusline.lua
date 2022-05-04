-- :fennel:1651600226
local modes = {n = "RW", no = "RO", v = "**", V = "**", ["\22"] = "**", s = "S", S = "SL", ["\19"] = "SB", i = "**", ic = "**", R = "RA", Rv = "RV", c = "VIEX", cv = "VIEX", ce = "EX", r = "r", rm = "r", ["r?"] = "r", ["!"] = "!", t = "t"}
local function color()
  local mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLine#"
  if (mode == "n") then
    mode_color = "%#StatusNormal#"
  elseif ((mode == "i") or (mode == "ic")) then
    mode_color = "%#StatusInsert#"
  elseif (((mode == "v") or (mode == "V")) or (mode == "\22")) then
    mode_color = "%#StatusVisual#"
  elseif (mode == "R") then
    mode_color = "%#StatusReplace#"
  elseif (mode == "c") then
    mode_color = "%#StatusCommand#"
  elseif (mode == "t") then
    mode_color = "%#StatusTerminal#"
  else
  end
  return mode_color
end
Statusline = {}
local function _2_()
  return table.concat({color(), string.format(" %s ", modes[vim.api.nvim_get_mode().mode]):upper(), "%#StatusLine#", " %f ", "%=", " %Y ", color(), " %l:%c "})
end
Statusline.active = _2_
vim.opt["laststatus"] = 3
vim.opt["showmode"] = false
vim.opt["statusline"] = "%!v:lua.Statusline.active()"
return nil