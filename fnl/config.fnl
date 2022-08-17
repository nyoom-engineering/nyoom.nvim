(require-macros :macros)
;; Place your private configuration here! Remember, you do not need to run 'nyoom
;; sync' after modifying this file!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set 'colorscheme' or manually load a theme through
;; 'require' function. This is the default:
(colorscheme oxocarbon)

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
