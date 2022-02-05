local _2afile_2a = "config.fnl"
local _2amodule_name_2a = "core"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local _ = nil
_2amodule_locals_2a["_"] = _
vim.api.nvim_set_option("mouse", "a")
vim.api.nvim_win_set_option(0, "number", false)
vim.api.nvim_buf_set_option(0, "modeline", true)
vim.api.nvim_buf_set_option(0, "undofile", true)
vim.api.nvim_buf_set_option(0, "swapfile", true)
vim.api.nvim_set_option("lazyredraw", true)
vim.api.nvim_set_option("ttyfast", true)
vim.api.nvim_set_option("updatetime", 100)
vim.api.nvim_set_option("cmdheight", 2)
vim.api.nvim_win_set_option(0, "list", true)
vim.api.nvim_win_set_option(0, "conceallevel", 2)
vim.api.nvim_win_set_option(0, "breakindent", true)
vim.api.nvim_win_set_option(0, "linebreak", true)
vim.api.nvim_set_option("inccommand", "nosplit")
vim.api.nvim_win_set_option(0, "signcolumn", "yes")
do end (vim.opt_local)["tabstop"] = 4
vim.opt_local["shiftwidth"] = 4
vim.opt_local["scrolloff"] = 3
vim.api.nvim_set_option("guifont", "Liga SFMono Nerd Font:h14")
do end (vim.opt)["clipboard"] = (vim.opt.clipboard + "unnamedplus")
do end (vim.opt)["fillchars"] = (vim.opt.fillchars + "eob: ")
do end (vim.opt_global)["expandtab"] = true
vim.opt["nrformats"] = (vim.opt.nrformats - "octal")
return nil