(import-macros {: use-package! : call-setup} :macros.package-macros)

(use-package! :brenoprata10/nvim-highlight-colors {:opt true
                                                   :config (call-setup nvim-highlight-colors)
                                                   :setup (fn []
                                                            ((. (require :utils.lazy-load)
                                                                :load-on-file-open!) :nvim-highlight-colors))})
