(import-macros {: use-package!} :macros)

(use-package! :ledger/vim-ledger
              {:nyoom-module lang.ledger
               :branch :main
               :after :nvim-treesitter
               })
