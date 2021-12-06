-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1
vim.g.shell = "/bin/bash" --fish has speed issues with nvim-tree
vim.g.neovide_cursor_vfx_mode = "pixiedust" -- neovide trail
--vim.opt.fillchars = { eob = " " } -- disable tilde fringe
vim.opt.undofile = true -- enable persistent undo
vim.opt.swapfile = false -- disable swap
vim.opt.cursorline = true -- enable cursorline
vim.opt.mouse = "a" -- enable mouse
vim.opt.signcolumn = "yes" -- enable signcolumn
vim.opt.updatetime = 250
vim.opt.clipboard = "unnamedplus" -- enable universal clipboard
vim.opt.scrolloff = 3 -- leave 3 lines up/down while scrolling
vim.opt.tabstop = 4 -- tabs should be 4 "space" wide
vim.opt.shiftwidth = 4 -- tabs should be 4 "space" wide
vim.opt.expandtab = true -- tabs should be 4 "space" wide
vim.opt.linebreak = true -- clean linebreaks
vim.opt.number = false -- disable numbers
vim.opt.numberwidth = 2 -- two wide number column
vim.opt.guifont = "Liga SFMono Nerd Font:h14" -- set guifont for neovide
vim.opt.shortmess:append "casI" -- disable intro
vim.opt.whichwrap:append "<>hl" -- clean aligned wraps
vim.opt.guicursor:append "i:blinkwait700-blinkon400-blinkoff250"

--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
