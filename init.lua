-- aniseed
--[[
require("impatient")
vim.g["aniseed#env"] = {
  module = "core.init",
  compile = true
}
--]]

-- hotpot
require("hotpot").setup({ modules = { correlate = true } })
require("core")
