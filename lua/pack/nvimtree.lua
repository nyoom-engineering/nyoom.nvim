-- :fennel:1651599946
vim.g["nvim_tree_show_icons"] = {git = 0, folders = 1, files = 0, folder_arrows = 0}
local function _3_(...)
  local meta_3_auto
  local function _2_(_241, _242)
    return (require("nvim-tree"))[_242]
  end
  meta_3_auto = {__index = _2_}
  local ret_4_auto = {}
  setmetatable(ret_4_auto, meta_3_auto)
  return ret_4_auto
end
local _local_1_ = _3_(...)
local setup = _local_1_["setup"]
return setup({view = {width = 30, side = "left", hide_root_folder = true}, hijack_cursor = true, update_cwd = true, renderer = {indent_markers = {enable = true}, icons = {webdev_colors = false}}, hijack_directories = {enable = true, auto_open = true}})