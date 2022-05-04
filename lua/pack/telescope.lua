-- :fennel:1651599955
local function _3_(...)
  local meta_3_auto
  local function _2_(_241, _242)
    return (require("telescope"))[_242]
  end
  meta_3_auto = {__index = _2_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_1_ = _3_(...)
local setup = _local_1_["setup"]
return setup({defaults = {prompt_prefix = " \239\128\130  ", selection_caret = "  ", entry_prefix = "  ", sorting_strategy = "ascending", layout_strategy = "flex", layout_config = {horizontal = {prompt_position = "top", preview_width = 0.55}, vertical = {mirror = false}, width = 0.87, height = 0.8, preview_cutoff = 120}, set_env = {COLORTERM = "truecolor"}, dynamic_preview_title = true}})