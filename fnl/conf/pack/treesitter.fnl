(import-macros {: set!} :conf.macros)
(local {: setup} (require :nvim-treesitter.configs))

;; orgmode.nvim uses modern gcc features which are not supported by clang. Lets force treesitter to compile using gcc
(tset (require :nvim-treesitter.install) :compilers {1 :gcc-11})

;; add orgmode parser
(local parser-config ((. (require :nvim-treesitter.parsers) :get_parser_configs)))
(set parser-config.org {:install_info {:url "https://github.com/milisims/tree-sitter-org"
                                       :revision :f110024d539e676f25b72b7c80b0fd43c34264ef
                                       :files {1 :src/parser.c
                                               2 :src/scanner.cc}}
                        :filetype :org})

;; the usual
(setup {:ensure_installed :maintained
        :highlight {:enable true 
                    :use_languagetree true
                    :disable {1 :org}
                    :additional_vim_regex_highlighting {1 :org}}
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
