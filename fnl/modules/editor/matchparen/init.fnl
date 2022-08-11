(import-macros {: use-package! : load-module : load-on-file-open!} :macros.package-macros)

(use-package! :monkoose/matchparen.nvim {:opt true
                                         :config (load-module editor.matchparen)
                                         :setup (load-on-file-open! matchparen.nvim)})
