(import-macros {: use-package! : set!} :macros)

(use-package! :lewis6991/spellsitter.nvim {:call-setup spellsitter
                                           :after :nvim-treesitter
                                           :config (fn []
                                                     (set! spell)
                                                     (set! spelllang [:en])
                                                     (set! spelloptions [:camel]))})
