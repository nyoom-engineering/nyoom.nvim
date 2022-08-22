(import-macros {: use-package!} :macros)

;; (ab)using use-package! for lazy-loading
(use-package! :editor.scratch {:nyoom-module editor.scratch
                               :cmd :Scratch})
