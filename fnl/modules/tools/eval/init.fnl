(import-macros {: use-package!} :macros)

;; interactive lisp evaluation
(use-package! :Olical/conjure {:branch :develop
                               :ft [:fennel :clojure :lisp :racket :scheme :rust :janet :lua :guile :python]
                               :config (tset vim.g "conjure#extract#tree_sitter#enabled" true)})
