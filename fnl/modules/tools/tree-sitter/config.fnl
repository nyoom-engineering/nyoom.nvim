(import-macros {: packadd! : nyoom-module-p! : map!} :macros)

;; Conditionally enable leap-ast

(nyoom-module-p! bindings
                 (do
                   (packadd! leap-ast.nvim)
                   (let [leap-ast (autoload :leap-ast)]
                     (map! [nxo] :gs `(leap-ast.leap) {:desc "Leap AST"}))))

(local treesitter-filetypes [:comment :help :fennel :vim :regex :query])

;; conditionally install parsers

(nyoom-module-p! clojure (table.insert treesitter-filetypes :clojure))

(nyoom-module-p! common-lisp (table.insert treesitter-filetypes :commonlisp))

(nyoom-module-p! java (table.insert treesitter-filetypes :java))

(nyoom-module-p! julia (table.insert treesitter-filetypes :julia))

(nyoom-module-p! kotlin (table.insert treesitter-filetypes :kotlin))

(nyoom-module-p! latex (table.insert treesitter-filetypes :latex))

(nyoom-module-p! lua (table.insert treesitter-filetypes :lua))

(nyoom-module-p! nix (table.insert treesitter-filetypes :nix))

(nyoom-module-p! python (table.insert treesitter-filetypes :python))

(nyoom-module-p! sh (table.insert treesitter-filetypes :bash))

(nyoom-module-p! sh.+fish (table.insert treesitter-filetypes :fish))

(nyoom-module-p! zig (table.insert treesitter-filetypes :zig))

(nyoom-module-p! cc
                 (do
                   (table.insert treesitter-filetypes :c)
                   (table.insert treesitter-filetypes :cpp)))

(nyoom-module-p! rust
                 (do
                   (table.insert treesitter-filetypes :rust)
                   (table.insert treesitter-filetypes :toml)))

(nyoom-module-p! markdown
                 (do
                   (table.insert treesitter-filetypes :markdown)
                   (table.insert treesitter-filetypes :markdown_inline)))

(nyoom-module-p! vc-gutter
                 (do
                   (table.insert treesitter-filetypes :git_rebase)
                   (table.insert treesitter-filetypes :gitattributes)
                   (table.insert treesitter-filetypes :gitcommit)))

;; (table.insert treesitter-filetypes :gitignore)))

(nyoom-module-p! org
                 (do
                   (local tsp (autoload :nvim-treesitter.parsers))
                   (local parser-config (tsp.get_parser_configs))
                   (set parser-config.org
                        {:filetype :org
                         :install_info {:url "https://github.com/milisims/tree-sitter-org"
                                        :files [:src/parser.c :src/scanner.cc]
                                        :branch :main}})
                   (table.insert treesitter-filetypes :org)))

(nyoom-module-p! neorg
                 (do
                   (local tsp (autoload :nvim-treesitter.parsers))
                   (local parser-config (tsp.get_parser_configs))
                   (set parser-config.norg
                        {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg"
                                        :files [:src/parser.c :src/scanner.cc]
                                        :branch :dev
                                        :use_makefile true}})
                   (set parser-config.norg_meta
                        {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                                        :files [:src/parser.c]
                                        :branch :main}})
                   (set parser-config.norg_table
                        {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                                        :files [:src/parser.c]
                                        :branch :main}})
                   (table.insert treesitter-filetypes :norg)
                   (table.insert treesitter-filetypes :norg_table)
                   (table.insert treesitter-filetypes :norg_meta)))

;; load dependencies

(packadd! nvim-ts-rainbow)
(packadd! nvim-treesitter-textobjects)
; the usual

(setup :nvim-treesitter.configs
       {:ensure_installed treesitter-filetypes
        :sync_install true
        :highlight {:enable true :use_languagetree true}
        :indent {:enable true}
        :rainbow {:enable true
                  :extended_mode true
                  :colors ["#878d96"
                           "#a8a8a8"
                           "#8d8d8d"
                           "#a2a9b0"
                           "#8f8b8b"
                           "#ada8a8"
                           "#878d96"]}
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
