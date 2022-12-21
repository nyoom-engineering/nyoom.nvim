(import-macros {: use-package!} :macros)

;; view bindings

(use-package! :ggandor/leap.nvim
              {:nyoom-module config.default.+bindings
               :requires [(pack :tpope/vim-repeat)
                          (pack :ggandor/leap-ast.nvim {:opt true})
                          (pack :numToStr/Comment.nvim
                                {:keys [:<leader>c :gb] :call-setup Comment})]})
