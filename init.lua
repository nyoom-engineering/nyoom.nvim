require[[hotpot]].setup({provide_require_fennel = true})
local compiled = (vim.fn.filereadable((vim.fn.stdpath("config") .. "/lua/packer_compiled.lua")) == 1)
if compiled then
  require[[packer_compiled]]
else
  require[[utils.sync]]
end
require[[core]]
