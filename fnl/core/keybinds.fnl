(import-macros {: map!} :macros.keybind-macros)
(import-macros {: let!} :macros.variable-macros)

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


;; >xiaobing add
;; Telescope
(map! [n] "<C-c><C-g>" "<cmd>Telescope ghq list<CR>")
(map! [n] "<leader>bb" "<cmd>Telescope buffers<CR>")
(map! [n] "<leader>pp" "<cmd>Telescope project<CR>")
(map! [n] "<leader>pf" "<cmd>Telescope file_browser<CR>")

;; Window
(map! [n] "<C-w><C-w>" "<cmd>lua require('nvim-window').pick()<CR>")

;; Explorer
(map! [n] "<leader>op" "<cmd>NvimTreeToggle<CR>")
(map! [n] "<leader>o-" "<cmd>NnnPicker %:p:h<CR>")

;; Terminal
(map! [n] "<leader>ot" "<cmd>exe v:count1 . 'ToggleTerm'<cr>")
(map! [n] "<leader>oT" "<cmd>ToggleTerm  direction=tab<cr>")

;; Search
(map! [n] "<leader>sb" "<cmd>Telescope current_buffer_fuzzy_find<cr>")
(map! [n] "<leader>sp" "<cmd>Telescope live_grep<cr>")


;; Git
(map! [n] "<leader>gg" "<cmd>ToggleLazygit<cr>")
;; <
