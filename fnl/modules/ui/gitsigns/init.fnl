(import-macros {: use-package! : call-setup} :macros.package-macros)

(use-package! :lewis6991/gitsigns.nvim {:ft :gitcommit
                                        :config (call-setup gitsigns)
                                        :setup (fn []
                                                 ((. (require :utils.lazy-load)
                                                     :load-gitsigns)))})
