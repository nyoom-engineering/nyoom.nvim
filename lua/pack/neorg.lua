-- :fennel:1651588459
local _local_1_ = require("neorg")
local setup = _local_1_["setup"]
return setup({load = {["core.defaults"] = {}, ["core.norg.concealer"] = {}, ["core.norg.qol.toc"] = {}, ["core.norg.completion"] = {config = {engine = "nvim-cmp"}}, ["core.norg.dirman"] = {config = {workspaces = {main = "~/org/neorg"}, autodetect = true, autochdir = true}}}})