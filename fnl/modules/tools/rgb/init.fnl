(import-macros {: use-package! : call-setup : load-on-file-open!} :macros.package-macros)

(use-package! :brenoprata10/nvim-highlight-colors {:opt true
                                                   :config (call-setup nvim-highlight-colors)
                                                   :setup (load-on-file-open! nvim-highlight-colors)})
