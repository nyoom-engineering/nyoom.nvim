(import-macros {: set! : let! : map!} :conf.macros)

;; This is going to be your introduction to the let! and set! macros
;; let! is used for vim.g. options. For example, (let! do_filetype_lua 1) expands to vim.g["do_filetype_lua"]=1.
;; set! is used for vim.opt options. For example, (set! mouse :a) expands to vim.opt["mouse"]="a"
;; if a string or number isn't passed to set!, it will assume true. e.g. (set! list) will expand to vim.opt["list"]=true
;; Similarly if the option starts with no, it will assume false e.g. (set! noru) will expand to vim.opt["ru"]=false

;; e.g. font for GUI's. You probably want to change this
(set! guifont "Liga SFMono Nerd Font:h15")

;; the map! macro is used for any mappings. It has the following syntax:
;; (map! [<mode>] :key1 :commandtorun)
;; e.g. (map! [i] :jk :<esc>) binds jk to <esc> in insert mode
;; the buf-map! macro is used for buffer-local mappings, like those needed for LSP
;; every default binding is aligned to the ones used in doom-emacs, with a few exceptions here and there.

;; e.g. jk/jj for escape. Some people like this, others don't
(map! [i] :jk :<esc>)
