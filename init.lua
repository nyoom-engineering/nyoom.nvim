-- Entrypoint for the neovim configuration
-- We simply bootstrap packer and hotpot here
-- It's then up to hotpot to compile and load fnl/conf/init.fnl

-- use opt-in filetype.lua instead of vimscript default
-- EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format

-- make the package path ~/.local/share/nvim/plug
local packer_path = fn.stdpath("data") .. "/site/pack"

function ensure(user, repo)
    local install_path = fmt("%s/packer/start/%s", packer_path, repo, repo)
        if fn.empty(fn.glob(install_path)) > 0 then
        execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
        execute(fmt("packadd %s", repo))
    end
end

-- Bootstrap essential plugins
ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")

-- impatient optimization
require("impatient")

fennel_compiler = "aniseed" -- change this to hotpot if you want to use hotpot

if fennel_compiler == "aniseed" then
    ensure("Olical", "aniseed")
    vim.g["aniseed#env"] = {module = "conf.init"}
elseif fennel_compiler == "hotpot" then
    ensure("rktjmp", "hotpot.nvim")
    require("hotpot").setup()
    require("conf")
else
    error("Unknown compiler")
end

