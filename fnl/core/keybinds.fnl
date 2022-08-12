(import-macros {: map! : let!} :macros)

;; set leader key
(let! mapleader " ")
(let! maplocalleader " m")

;; Disable highlight on escape
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

;; Easier command-line mode
(map! [n] ";" ":")

;; Some keybindings stolen from doom
(map! [n] "<leader><space>" "<cmd>Telescope find_files<CR>")
(map! [n] "<leader>bb" "<cmd>Telescope buffers<CR>")
(map! [n] "<leader>:" "<cmd>Telescope commands<CR>")
