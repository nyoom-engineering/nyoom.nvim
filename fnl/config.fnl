;; Here you can import the nesseccary macros and functions. Please read `macros.norg` for a full list of macros
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
(import-macros {: colorscheme : set! : let! : map!} :macros)

;; Here you can import functions from nyoom's core library. Please read `core.norg` for a full list of helper functions.
(local {: autoload} (require :core.lib.autoload))
(local {: after} (autoload :core.lib.setup))

;; You can use the `colorscheme` macro to load a custom theme, or load it manually
;; via require. This is the default:
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
(map! [n] :<esc> :<esc><cmd>noh<cr>)

;; sometimes you want to modify a plugin thats loaded from within a module. For this you can use the `after` function
(after :neorg
       {:load {:core.norg.dirman {:config {:workspaces {:main "~/neorg"}}}}})
