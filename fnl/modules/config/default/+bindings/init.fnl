(import-macros {: use-package!} :macros)

;; view bindings
(use-package! :ggandor/leap.nvim {:nyoom-module config.default.+bindings
                                  :requires [(pack :ggandor/leap-ast.nvim {:opt true})
                                             (pack :numToStr/Comment.nvim {:opt true
                                                                           :defer Comment.nvim
                                                                           :call-setup Comment})]})
