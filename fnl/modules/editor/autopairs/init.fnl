(import-macros {: use-package! : call-setup} :macros.package-macros)
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(use-package! :windwp/nvim-autopairs {:event :InsertEnter :config (fn []
                                                                    ((. (require :nvim-autopairs) :setup) {:disable_filetype lisp-ft}))})
