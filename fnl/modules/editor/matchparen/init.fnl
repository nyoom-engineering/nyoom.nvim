(import-macros {: use-package! : load-module} :macros.package-macros)
(use-package! :monkoose/matchparen.nvim {:opt true
                                         :config (load-module editor.matchparen)
                                         :setup (fn []
                                                  ((. (require :utils.lazy-load)
                                                      :load-on-file-open!) :matchparen.nvim))})
