--[[
Entrypoint for the neovim configuration
We simply bootstrap packer and hotpot/aniseed
It's then up to hotpot or aniseed to compile and load fnl/conf/init.fnl
--]]

-- use opt-in filetype.lua instead of vimscript default
-- EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

function ensure(user, repo)
    local install_path = string.format("%s/packer/start/%s", vim.fn.stdpath("data") .. "/site/pack", repo, repo)
        if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.api.nvim_command(string.format("!git clone https://github.com/%s/%s %s", user, repo, install_path))
        vim.api.nvim_command(string.format("packadd %s", repo))
    end
end

-- Bootstrap essential plugins
ensure("wbthomason", "packer.nvim")
ensure("lewis6991", "impatient.nvim")

-- impatient optimization
require("impatient")

-- global variable to set the user's fennel compiler
fennel_compiler = "hotpot"

if fennel_compiler == "aniseed" then
    ensure("Olical", "aniseed")
    vim.g["aniseed#env"] = {module = "conf.init"}
elseif fennel_compiler == "hotpot" then
    ensure("rktjmp", "hotpot.nvim")
    require("hotpot").setup({
       provide_require_fennel = true,
       compiler = {
         modules = {
           correlate = true
         }
       }
     })
    require("conf")
else
    error("Unknown compiler")
end

