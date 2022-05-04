-- :fennel:1651676635
local function _3_(...)
  local meta_3_auto
  local function _2_(_241, _242)
    return (require("true-zen"))[_242]
  end
  meta_3_auto = {__index = _2_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_1_ = _3_(...)
local setup = _local_1_["setup"]
return setup({ui = {bottom = {cmdheight = 1, laststatus = 0, ruler = true, showmode = false, showcmd = false}, left = {number = false, relativenumber = false, signcolumn = "no"}}, modes = {ataraxis = {left_padding = 32, right_padding = 32, top_padding = 1, bottom_padding = 1, ideal_writing_area_width = {0}, auto_padding = false, bg_configuration = true}, focus = {margin_of_error = 5, focus_method = "experimental"}}})