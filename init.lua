require[[hotpot]].setup()
local compiled = (vim.fn.filereadable((vim.fn.stdpath("config") .. "/lua/packer_compiled.lua")) == 1)
if compiled then
  require[[packer_compiled]]
else
  require[[core.sync]]
end
require[[core]]
