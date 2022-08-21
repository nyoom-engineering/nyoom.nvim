(local {: setup} (require :nvim-autopairs))
(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

(setup {:disable_filetype lisp-ft})
