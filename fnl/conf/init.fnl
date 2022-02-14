(import-macros {: unpack!} :conf.macros)

;; here you can enable/disable modules
(local nyoom_modules {1 :core        ;; what makes nyoom nyoom! This shouldn't really be a module
                      2 :base16      ;; colors, everywhere!
                      3 :lsp         ;; I'm sure you've heard of it by now
                      4 :completion  ;; the ultimate code completion backend
                      5 :lispy
                      6 :neorg
                      7 :orgmode
                      8 :prettify
                      9 :telescope
                      10 :treesitter
                      11 :zen})

(each [_ modulename (ipairs nyoom_modules)]
  (local (ok err) (pcall require (.. :conf.modules. modulename)))
  (when (not ok)
    (error (.. "Error loading " modulename "\n\n" err))))

;; Initialize packer and pass each package to the packer.nvim plugin.
(unpack!)
