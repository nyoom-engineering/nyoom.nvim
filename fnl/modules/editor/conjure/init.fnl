(import-macros {: use-package!} :macros.package-macros)
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(use-package! :Olical/conjure {:branch :develop
                               :ft lisp-ft
                               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)})


