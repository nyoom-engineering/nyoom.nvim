(import-macros {: map!} :conf.macros)

;; jk/jj for escape 
(map! [i] :jk :<esc>)

;; no highlight on escape
(map! [n] :<esc> :<esc><cmd>noh<cr>)

;; easier command line mode
(map! [n] ";" ":")
(map! [v] ";" ":")

;; wrap/unwrap
(map! [n] :<leader>w "<cmd>set wrap!<CR>")

;; treesitter 
(map! [n] :<Leader>th ":TSHighlightCapturesUnderCursor<CR>")
(map! [n] :<Leader>tp ":TSPlayground<CR>")

;; telescope
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")
(map! [n] :<leader>b "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>r "<cmd>Telescope frecency<CR>")
(map! [n] :<leader>. "<cmd>Telescope file_browser<CR>")
(map! [n] :<leader>f "<cmd>Telescope current_buffer_fuzzy_find<CR>")
(map! [n] :<leader>p "<cmd>Telescope packer<CR>")
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>")

;; truezen
(map! [n] :<leader>z :<cmd>TZAtaraxis<CR>)
