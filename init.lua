-- Entrypoint for my Neovim configuration!
-- We simply bootstrap packer and Aniseed here, as well as load impatient and some optimizations
-- It's then up to Aniseed to compile and load fnl/config/init.fnl

-- use opt-in filetype.lua instead of vimscript default
-- EXPERIMENTAL: https://github.com/neovim/neovim/pull/16600
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

-- fish has speed issues with nvim-tree. Adjust this if you
-- 1. already have your default shell as zsh/sh/bash or
-- 2. Have your default shell in a different location
vim.g.shell = "/bin/bash"

--disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

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

-- Bootstrap essential plugins required for installing and loading the rest.
ensure("lewis6991", "impatient.nvim")
ensure("wbthomason", "packer.nvim")
ensure("Olical", "aniseed")

-- Load impatient which pre-compiles and caches Lua modules.
require("impatient")

-- only load plugins if packer has compiled them
pcall(require, "packer_compiled")

-- load aniseed environment
vim.g["aniseed#env"] = { module = "init" }
