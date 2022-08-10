;; This file controls what Nyoom modules are enabled and what order they load
;; in. Remember to run 'PackerSync' after modifying it!

;; completion
(include :fnl.modules.completion.cmp)
(include :fnl.modules.completion.telescope)
;; (include :fnl.modules.completion.compleet)

;; editor
(include :fnl.modules.editor.autopairs)
(include :fnl.modules.editor.conjure)
(include :fnl.modules.editor.hydras)
(include :fnl.modules.editor.leap)
(include :fnl.modules.editor.matchparen)
;; (include :fnl.modules.editor.parinfer)

;; lang
(include :fnl.modules.lang.java)
(include :fnl.modules.lang.neorg)
(include :fnl.modules.lang.rust)

;; tools
(include :fnl.modules.tools.lsp)
(include :fnl.modules.tools.neogit)
;; (include :fnl.modules.tools.profile)
(include :fnl.modules.tools.rgb)
(include :fnl.modules.tools.treesitter)

;; ui 
(include :fnl.modules.ui.gitsigns)
(include :fnl.modules.ui.notify)
(include :fnl.modules.ui.nvimtree)
(include :fnl.modules.ui.truezen)

;; (nyoom!
;;   :completion
;;   cmp
;;   telescope
;;   ;; compleet
;;   :editor
;;   autopairs
;;   conjure
;;   hydras
;;   leap
;;   matchparen
;;   ;; parinfer
;;   :lang
;;   java
;;   neorg
;;   rust
;;   :tools
;;   lsp
;;   neogit
;;   ;; profile
;;   rgb
;;   treesitter
;;   :ui
;;   gitsigns
;;   notify
;;   truezen)
