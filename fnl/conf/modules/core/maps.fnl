(import-macros {: let! : map!} :conf.macros)

;; add doom-style leader keys
(let! mapleader " ")
(let! maplocalleader " m")

;; no highlight on escape
(map! [n] :<esc> :<esc><cmd>noh<cr>)

;; easier command line mode
(map! [n] ";" ":")
(map! [v] ";" ":")

;; wrap/unwrap
(map! [n] :<leader>tw "<cmd>set wrap!<CR>")
