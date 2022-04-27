(import-macros {: set!} :conf.macros)
(local {: setup} (require :nvim-treesitter.configs))

;; the usual
(setup {:ensure_installed [:lua :fennel]
        :highlight {:enable true :use_languagetree true}
        :indent {:enable true}
        :rainbow {:enable true :extended_mode true}})
