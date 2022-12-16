(import-macros {: use-package!} :macros)
;; view bindings

(use-package! :ggandor/leap.nvim
              {:nyoom-module config.default.+bindings
               :requires [(pack :ggandor/leap-ast.nvim {:opt true})
                          (pack :tpope/vim-repeat)
                          (pack :numToStr/Comment.nvim
                                {:keys [:<leader>c :gb] :call-setup Comment})]})
