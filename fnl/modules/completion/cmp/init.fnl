(import-macros {: use-package! : pack} :macros)

;; standard completion for neovim
(use-package! :hrsh7th/nvim-cmp
              {:nyoom-module completion.cmp
               :event [:InsertEnter :CmdLineEnter]
               :requires [(pack :hrsh7th/cmp-path {:opt true})               ;; path completion
                          (pack :hrsh7th/cmp-buffer {:opt true})             ;; buffer completion
                          (pack :hrsh7th/cmp-nvim-lsp {:opt true})           ;; lsp completion
                          (pack :hrsh7th/cmp-cmdline {:opt true})            ;; cmdline completion
                          (pack :PaterJason/cmp-conjure {:after :conjure})   ;; conjure completion
                          (pack :saadparwaiz1/cmp_luasnip {:opt true})       ;; snippet completion
                          (pack :rafamadriz/friendly-snippets {:opt true})
                          (pack :L3MON4D3/LuaSnip {:opt true})]})


