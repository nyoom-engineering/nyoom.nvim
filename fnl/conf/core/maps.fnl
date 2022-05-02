(import-macros {: let! : map!} :conf.macros)

;; add leader keys
(let! :g.mapleader " ")

;; who actually uses C-z or ex mode?
(map! [n] :<C-z> :<Nop>)
(map! [n] :Q :<Nop>)

;; easier command line mode
(map! [n] ";" ":")
(map! [v] ";" ":")

;; move between windows
(map! [n] :<C-h> :<C-w>h)
(map! [n] :<C-j> :<C-w>j)
(map! [n] :<C-k> :<C-w>k)
(map! [n] :<C-l> :<C-w>l)

;; Resize splits
(map! [n] :<C-Up> "<cmd>resize +2<cr>")
(map! [n] :<C-Down> "<cmd>resize -2<cr>")
(map! [n] :<C-Left> "<cmd>vertical resize +2<cr>")
(map! [n] :<C-Right> "<cmd>vertical resize -2<cr>")

;; wrap/unwrap
(map! [n] :<leader>w "<cmd>set wrap!<CR>")

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; telescope
(map! [n] :<leader>b "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>f "<cmd>Telescope current_buffer_fuzzy_find<CR>")
(map! [n] :<leader>r "<cmd>Telescope oldfiles<CR>")
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>")

;; nvimtree
(map! [n] :<leader>o "<cmd>NvimTreeToggle<CR>")

;; truezen
(map! [n] :<leader>z :<cmd>TZAtaraxis<CR>)

