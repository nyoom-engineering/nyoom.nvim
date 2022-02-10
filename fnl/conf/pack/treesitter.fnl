(import-macros {: set!} :conf.macros)
(local {: setup} (require :nvim-treesitter.configs))

(setup {:ensure_installed :maintained
        :highlight {:enable true :use_languagetree true}
        :indent {:enable true}
        :rainbow {:enable true
                  :extended_mode true
                  :max_file_lines 1000
                  :colors {1 "#878d96"
                           2 "#a8a8a8"
                           3 "#8d8d8d"
                           4 "#a2a9b0"
                           5 "#8f8b8b"
                           6 "#ada8a8"}}
        :textobjects {:select {:enable true
                               :lookahead true
                               :keymaps {:if "@function.inner"
                                         :af "@function.outer"
                                         :ic "@class.inner"
                                         :ac "@class.outer"
                                         :ia "@parameter.inner"
                                         :aa "@parameter.outer"}}
                      :swap {:enable true
                             :swap_next {:<localleader>> "@parameter.inner"}
                             :swap_previous {:<localleader>< "@parameter.inner"}}}})
