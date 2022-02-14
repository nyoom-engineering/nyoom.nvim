(import-macros {: use-package! : pack} :conf.macros)

(local lisp-ft [:fennel :clojure :lisp :racket :scheme])

;; lispy configs
(use-package! :Olical/conjure
              {:branch :develop
               :ft lisp-ft
               :requires [(pack :gpanders/nvim-parinfer {:ft lisp-ft})
                          (if (= fennel_compiler :aniseed)
                              (do
                                (pack :Olical/aniseed {:branch :develop}))
                              (= fennel_compiler :hotpot)
                              (do
                                (pack :rktjmp/hotpot.nvim)))]})
