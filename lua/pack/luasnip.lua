-- :fennel:1651632832
local function _3_(...)
  local meta_3_auto
  local function _2_(_241, _242)
    return (require("luasnip"))[_242]
  end
  meta_3_auto = {__index = _2_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_1_ = _3_(...)
local config = _local_1_["config"]
local function _6_(...)
  local meta_3_auto
  local function _5_(_241, _242)
    return (require("luasnip/loaders/from_vscode"))[_242]
  end
  meta_3_auto = {__index = _5_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_4_ = _6_(...)
local load = _local_4_["load"]
config.set_config({history = true, updateevents = "TextChanged,TextChangedI"})
return load()