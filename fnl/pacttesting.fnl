(import-macros {: let! : set! : pact-use-package!} :macros)

;; TODO
;; - adapt to v0.0.10 syntax
;; - add lazy support for keybinds
;; - more robust lazy cmd handling 
;; - maybe change up the syntax?

;; fnlfmt: skip
;; (pact-use-package! :testrepo/nvim-plugin {:version :>2.5.0
;;                                           :host :github
;;                                           :command :TestCmd
;;                                           :event [:TestEvent1 :TestEvent2]
;;                                           :ft [:ft2 :ft3]
;;                                           :defer 2
;;                                           :bind {:0 :TestCmd1
;;                                                  :1 :TestCmd2}
;;                                           :init (do
;;                                                  (set! number)
;;                                                  (let! neo_tree_remove_legacy_commands 1))
;;                                           :config (do
;;                                                     (setup :nvim-plugin {:option1 true})
;;                                                     (more-setup-here))})
