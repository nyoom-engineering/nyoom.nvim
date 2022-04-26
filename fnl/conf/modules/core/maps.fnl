(import-macros {: let! : map!} :conf.macros)

;; add leader keys
(let! mapleader " ")
(let! maplocalleader ",")

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
(map! [n] :<leader>b "<cmd>Telescope buffers<CR>")
(map! [n] :<leader>ff "<cmd>Telescope current_buffer_fuzzy_find<CR>")
(map! [n] :<leader>fr "<cmd>Telescope oldfiles<CR>")
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")
(map! [n] :<leader><space> "<cmd>Telescope find_files<CR>")

;; truezen
(map! [n] :<leader>z :<cmd>TZAtaraxis<CR>)

;; we only want these mappings active if hotpot is active 
(if (= fennel_compiler :hotpot)
    (do
      (map! [v] :<leader>e
            "<cmd>lua print(require('hotpot.api.eval')['eval-selection']())<CR>")
      (map! [v] :<leader>c
            "<cmd>lua print(require('hotpot.api.compile')['compile-selection']())<CR>")
      (map! [n] :<leader>c
            "<cmd>lua print(require('hotpot.api.compile')['compile-buffer'](0))<CR>")))


