-- :fennel:1651633589
vim.g["did_load_filetypes"] = 1
vim.g["do_filetype_lua"] = 1
do
  local built_ins = {"gzip", "zip", "zipPlugin", "tar", "tarPlugin", "getscript", "getscriptPlugin", "vimball", "vimballPlugin", "2html_plugin", "matchit", "matchparen", "logiPat", "rrhelper", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers"}
  local providers = {"perl", "node", "ruby", "python", "python3"}
  for _, v in ipairs(built_ins) do
    local plugin = ("loaded_" .. v)
    do end (vim.g)[plugin] = 1
  end
  for _, v in ipairs(providers) do
    local provider = ("loaded_" .. v .. "_provider")
    do end (vim.g)[provider] = 0
  end
end
require("core.defs")
require("core.maps")
require("pack.pack")
if (vim.fn.filereadable((vim.fn.stdpath("config") .. "/lua/packer_compiled.lua")) == 1) then
  require("packer_compiled")
else
end
return require("utils.statusline")