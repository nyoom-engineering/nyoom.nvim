-- :fennel:1651633258
vim.g["mapleader"] = " "
vim.opt["hidden"] = true
vim.opt["completeopt"] = {"menu", "menuone", "preview", "noinsert"}
vim.opt["clipboard"] = "unnamedplus"
vim.opt["mouse"] = "a"
vim.opt["lazyredraw"] = true
vim.opt["swapfile"] = false
vim.opt["ruler"] = false
vim.opt["number"] = false
vim.opt["termguicolors"] = true
vim.opt["signcolumn"] = "auto:1-3"
vim.opt["fillchars"] = {eob = " ", horiz = "\226\148\129", horizup = "\226\148\187", horizdown = "\226\148\179", vert = "\226\148\131", vertleft = "\226\148\171", vertright = "\226\148\163", verthoriz = "\226\149\139", fold = " ", diff = "\226\148\128", msgsep = "\226\128\190", foldsep = "\226\148\130", foldopen = "\226\150\190", foldclose = "\226\150\184"}
vim.opt["smartcase"] = true
vim.opt["ignorecase"] = true
vim.opt["copyindent"] = true
vim.opt["tabstop"] = 4
vim.opt["expandtab"] = true
vim.opt["conceallevel"] = 2
vim.opt["splitright"] = true
vim.opt["scrolloff"] = 8
vim.opt["cursorline"] = false
return nil