(import-macros {: use-package!} :macros)

(use-package! :nvim-orgmode/orgmode {:nyoom-module lang.org
                                     :ft :org
                                     :after :nvim-treesitter})

(use-package! :dhruvasagar/vim-table-mode {:cmd :TableModeToggle})
