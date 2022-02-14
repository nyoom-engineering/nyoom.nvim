(import-macros {: use-package! : pack} :conf.macros)

(use-package! :nvim-orgmode/orgmode
              {:init :orgmode
               :ft :org
               :after :nvim-treesitter
               :requires (pack :akinsho/org-bullets.nvim
                               {:ft :org
                                :init :org-bullets})})
