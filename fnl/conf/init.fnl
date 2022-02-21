;; Nyoom modules are loaded first

;; don't enable any of these for now, they don't exist. WIP
(require :conf.modules.core)

;;(include :conf.completion.cmp)
;;(include :conf.completion.autopairs)
;;(include :conf.completion.telescope)
;;(include :conf.editor.fold)
;;(include :conf.editor.format)
;;(include :conf.editor.lispy)
;;(include :conf.editor.parinfer)
;;(include :conf.lang.cc)
;;(include :conf.lang.clojure)
;;(include :conf.lang.java)
;;(include :conf.lang.latex)
;;(include :conf.lang.lua)
;;(include :conf.lang.neorg)
;;(include :conf.lang.nix)
;;(include :conf.lang.org)
;;(include :conf.lang.rust)
;;(include :conf.tools.debugger)
;;(include :conf.tools.eval)
;;(include :conf.tools.format)
;;(include :conf.tools.lsp)
;;(include :conf.tools.luasnip)
;;(include :conf.tools.neogit)
;;(include :conf.tools.rgb)
;;(include :conf.ui.hl-todo)
;;(include :conf.ui.indent-guides)
;;(include :conf.ui.modeline)
;;(include :conf.ui.neotree)
;;(include :conf.ui.nyoom-dashboard)
;;(include :conf.ui.tabs)
;;(include :conf.ui.vc-gutter)
;;(include :conf.ui.vi-tilde-fringe)
;;(include :conf.ui.zen)

;; User config is loaded second
(require :conf.config)

;; packer config is loaded last
(require :conf.pack)

