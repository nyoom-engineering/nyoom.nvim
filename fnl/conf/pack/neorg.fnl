(local {: setup} (require :neorg))

(setup {:load {:core.defaults {}
               :core.norg.concealer {}
               :core.norg.qol.toc {}
               :core.norg.completion {:config {:engine :nvim-cmp}}
               :core.norg.dirman {:config {:workspaces {:main "~/org/neorg"} ; change this to your workspace, this is just mine
                                           :autodetect true
                                           :autochdir true}}}})


;; neorg treesitter parsers
(local parser-config
       ((. (require :nvim-treesitter.parsers) :get_parser_configs)))

(set parser-config.norg_meta
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
                     :files [:src/parser.c]
                     :branch :main}})

(set parser-config.norg_table
     {:install_info {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
                     :files [:src/parser.c]
                     :branch :main}})

