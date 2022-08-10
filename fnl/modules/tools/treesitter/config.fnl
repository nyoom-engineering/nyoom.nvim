(local tsp (require :nvim-treesitter.parsers))
(local {: setup} (require :nvim-treesitter.configs))

;;; Extra parsers
(local parser-config (tsp.get_parser_configs))

;; neorg treesitter parsers 
(set parser-config.norg {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                                        :files [:src/parser.c :src/scanner.cc]
                                        :branch :main}})

(set parser-config.norg_meta
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                     :files [:src/parser.c]
                     :branch :main}})

(set parser-config.norg_table
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                     :files [:src/parser.c]
                     :branch :main}})

;; the usual
(setup {:ensure_installed :all
        :ignore_install [:phpdoc :norg]
        :highlight {:enable true :use_languagetree true}
        :rainbow {:enable true 
                  :extended_mode true
                  :colors [:#878d96
                           :#a8a8a8
                           :#8d8d8d
                           :#a2a9b0
                           :#8f8b8b
                           :#ada8a8
                           :#878d96]}
        :incremental_selection {:enable true
                                :keymaps {:init_selection :gnn
                                          :node_incremental :grn
                                          :scope_incremental :grc
                                          :node_decremental :grm}}  
        :textobjects {:select {:enable true}
                      :lookahead true
                      :keymaps {:af "@function.outer"
                                :if "@function.inner"
                                :ac "@class.outer"
                                :ic "@class.inner"}  
                      :move {:enable true
                             :set_jumps true
                             :goto_next_start {"]m" "@function.outer"
                                               "]]" "@class.outer"}
                             :goto_next_end {"]M" "@function.outer"
                                             "][" "@class.outer"}
                             :goto_previous_start {"[m" "@function.outer"
                                                   "[[" "@class.outer"}
                             :goto_previous_end {"[M" "@function.outer"
                                                 "[]" "@class.outer"}}}})  
