(local {: autoload} (require :core.lib.autoload))
(local {: setup} (require :core.lib.setup))

(local lisp-ft [:fennel :clojure :lisp :racket :scheme])
(setup :nvim-autopairs {:disable_filetype lisp-ft})
