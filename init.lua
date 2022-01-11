-- Nyoom.nvim, Blazing fast neovim config
-- Author: Shaurya Singh (@shaunsingh)

--load impatient first
local present, impatient = pcall(require, 'impatient')

-- use opt-in filetype.lua instead of vimscript default
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

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

-- load options, mappings, and plugins
local nyoom_modules = {
   "config",
   "options",
   "mappings",
   "packer_compiled",
}

for i = 1, #nyoom_modules, 1 do
   pcall(require, nyoom_modules[i])
end

-- since we lazy load packer.nvim, we need to load it when we run packer-related commands
vim.cmd "silent! command PackerCompile lua require 'pluginList' require('packer').compile()"
vim.cmd "silent! command PackerInstall lua require 'pluginList' require('packer').install()"
vim.cmd "silent! command PackerStatus lua require 'pluginList' require('packer').status()"
vim.cmd "silent! command PackerSync lua require 'pluginList' require('packer').sync()"
vim.cmd "silent! command PackerUpdate lua require 'pluginList' require('packer').update()"


