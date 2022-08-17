(import-macros {: use-package!} :macros)

;; view bindings
(use-package! :ggandor/leap.nvim {:nyoom-module config.bindings
                                  :requires [(pack :ggandor/leap-ast.nvim {:opt true})]})
