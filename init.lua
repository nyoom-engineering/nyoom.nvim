require('import')
require('hotpot').setup({ provide_require_fennel = true })
local compiled = (vim.fn.filereadable((vim.fn.stdpath("config") .. "/lua/packer_compiled.lua")) == 1)
if compiled then
    import('packer_compiled')
end
import('core')
