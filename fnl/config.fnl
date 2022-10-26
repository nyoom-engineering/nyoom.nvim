(require-macros :macros)

;; Place your private configuration here! Remember, you do not need to run 'nyoom
;; sync' after modifying this file!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set 'colorscheme' or manually load a theme through
;; 'require' function. This is the default:
(colorscheme carbon)

;; The set! macro sets vim.opt options. By default it sets the option to true 
;; Appending `no` in front sets it to false. This determines the style of line 
;; numbers in effect. If set to nonumber, line numbers are disabled. For 
;; relative line numbers, set 'relativenumber`
(set! nonumber)

;; The let option sets global, or `vim.g` options. 
;; Heres an example with localleader, setting it to <space>m
(let! maplocalleader " m")

;; map! is used for mappings
;; Heres an example, preseing esc should also remove search highlights
(map! [n] "<esc>" "<esc><cmd>noh<cr>")

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
;;(map! [n] "<leader>o-" "<cmd>NnnPicker %:p:h<CR>")

;; Terminal
(map! [n] "<leader>ot" "<cmd>exe v:count1 . 'ToggleTerm'<cr>")
(map! [n] "<leader>oT" "<cmd>ToggleTerm  direction=tab<cr>")

;; Search
(map! [n] "<leader>sb" "<cmd>Telescope current_buffer_fuzzy_find<cr>")
(map! [n] "<leader>sp" "<cmd>Telescope live_grep<cr>")

;; Git
(map! [n] "<leader>gg" "<cmd>ToggleLazygit<cr>")

;; WIndow
(map! [in] "<C-x>0" "<cmd>bd<cr>")
(map! [in] "<C-x>1" "<cmd>only<cr>")
;; <

;; Poke around the Nyoom code for more! The following macros are also available:
;; contains? check if a table contains a value
;; custom-set-face! use nvim_set_hl to set a highlight value
;; set! set a vim option
;; local-set! buffer-local set!
;; command! create a vim user command
;; local-command! buffer-local command!
;; autocmd! create an autocmd
;; augroup! create an augroup
;; clear! clear events
;; packadd! force load a plugin from /opt
;; colorscheme set a colorscheme
;; map! set a mapping
;; buf-map! bufer-local mappings
;; let! set a vim global
;; echo!/warn!/err! emit vim notifications
