local default_plugins = {"2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "syntax", "synmenu", "optwin", "compiler", "bugreport", "ftplugin"}
local default_providers = {"node", "perl", "ruby"}
for _, plugin in pairs(default_plugins) do
  vim.g[("loaded_" .. plugin)] = 1
end
for _, provider in ipairs(default_providers) do
  vim.g[("loaded_" .. provider .. "_provider")] = 0
end
if pcall(require, "hotpot") then
  local function _3_(src, _1_)
    local _arg_2_ = _1_
    local path = _arg_2_["path"]
    local modname = _arg_2_["modname"]
    local macro_3f = _arg_2_["macro?"]
    if not macro_3f then
      return print(path, modname, string.match(path, "config/nvim/"))
    else
      local _4_ = string.match(path, "config/nvim/")
      if (_4_ == nil) then
        return src
      elseif true then
        local _any = _4_
        local pre = "(require-macros :macros)"
        return string.format("%s%s", pre, src)
      else
        return nil
      end
    end
  end
  do end (require("hotpot")).setup({enable_hotpot_diagnostics = true, provide_require_fennel = true, compiler = {macros = {allowGlobals = true, compilerEnv = _G, env = "_COMPILER"}, modules = {correlate = true, useBitLib = true}}})
  if os.getenv("NYOOM_PROFILE") then
    do end (require("core.lib.profile")).toggle()
  else
  end
  local stdlib = require("core.lib")
  for k, v in pairs(stdlib) do
    rawset(_G, k, v)
  end
  return require("core")
else
  return print("Unable to require hotpot")
end 


