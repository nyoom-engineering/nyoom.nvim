(module treesitter {require-macros [macros]})

(opt- nvim-treesitter.configs setup
      {:ensure_installed {1 :fennel 2 :lua}
       :highlight {:enable true :use_languagetree true}
       :indent {:enable true}
       :incremental_selection {:enable true
                               :keymaps {:init_selection :gnn
                                         :node_decremental :grm
                                         :node_incremental :grn
                                         :scope_incremental :grc}}
       :rainbow {:enable true
                 :extended_mode true
                 :max_file_lines 1000
                 :colors {1 "#878d96"
                          2 "#a8a8a8"
                          3 "#8d8d8d"
                          4 "#a2a9b0"
                          5 "#8f8b8b"
                          6 "#ada8a8"}}})

;; load context
(opt- treesitter-context.config setup {:enable true})
