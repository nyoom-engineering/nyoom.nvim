(local {: setup} (require :nvim-autopairs))
(local {: lisp-ft} (require :pack.pack))

(setup {:disable_filetype [:fennel :clojure :lisp :racket :scheme]})
