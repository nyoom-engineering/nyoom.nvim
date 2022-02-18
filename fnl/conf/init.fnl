;; Nyoom modules are loaded first

;; don't enable any of these for now, they don't exist. WIP
(local nyoom_modules {1 :core})
                      ;; 2 :completion.cmp
                      ;; 3 :completion.autopairs
                      ;; 4 :completion.telescope
                      ;; 5 :editor.fold
                      ;; 6 :editor.format
                      ;; 7 :editor.lispy
                      ;; 8 :editor.parinfer
                      ;; 9 :lang.cc
                      ;; 10 :lang.clojure
                      ;; 11 :lang.java
                      ;; 12 :lang.latex
                      ;; 13 :lang.lua
                      ;; 14 :lang.neorg
                      ;; 15 :lang.nix
                      ;; 16 :lang.org
                      ;; 17 :lang.rust
                      ;; 18 :tools.debugger
                      ;; 19 :tools.eval
                      ;; 20 :tools.format
                      ;; 21 :tools.lsp
                      ;; 21 :tools.luasnip
                      ;; 22 :tools.neogit
                      ;; 23 :tools.rgb
                      ;; 24 :ui.hl-todo
                      ;; 25 :ui.indent-guides
                      ;; 26 :ui.modeline
                      ;; 27 :ui.neotree
                      ;; 28 :ui.nyoom-dashboard
                      ;; 29 :ui.tabs
                      ;; 30 :ui.vc-gutter
                      ;; 31 :ui.vi-tilde-fringe
                      ;; 32 :ui.zen})

(each [_ modulename (ipairs nyoom_modules)]
  (local (ok err) (pcall require (.. :conf.modules. modulename)))
  (when (not ok)
    (error (.. "Error loading " modulename "\n\n" err))))

;; User config is loaded second
(require :conf.config)

;; packer config is loaded last
(require :conf.pack)

