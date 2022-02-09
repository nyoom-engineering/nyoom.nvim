(module maps {require-macros [macros]})

;; no highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;; easier command line mode
(map! [n] ";" ":")
(map! [v] ";" ":")

;; wrap/unwrap
(map! [n] :<leader>tw "<cmd>set wrap!<CR>")

;; treesitter 
(map! [n] :<Leader>h ":TSHighlightCapturesUnderCursor<CR>")

;; telescope
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")
(map! [n] :<leader>bb "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>fr "<cmd>Telescope oldfiles<CR>")
(map! [n] :<leader>. "<cmd>Telescope find_files<CR>")
(map! [n] :<leader>f "<cmd>Telescope current_buffer_fuzzy_find<CR>")

;; truezen
(map! [n] :<leader>tz :<cmd>TZAtaraxis<CR>)
