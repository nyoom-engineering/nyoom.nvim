(import-macros {: use-package! : pack} :macros)

(use-package! :kevinhwang91/nvim-ufo {:after :nvim-treesitter
                                      :requires [(pack :kevinhwang91/promise-async {:opt true})]})
