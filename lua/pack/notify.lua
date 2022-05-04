-- :fennel:1651590619
vim.notify = require("notify")
local _local_1_ = require("notify")
local setup = _local_1_["setup"]
return setup({stages = "fade_in_slide_out", fps = 60, icons = {ERROR = "\239\129\151", WARN = "\239\129\170", INFO = "\239\129\154", DEBUG = "\239\134\136", TRACE = "\226\156\142"}})