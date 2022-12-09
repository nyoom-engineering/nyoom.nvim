(import-macros {: use-package! : pack} :macros)

;; standard completion for neovim
(use-package! :hrsh7th/nvim-cmp
              {:nyoom-module completion.cmp
               :module :cmp
               :wants :LuaSnip
               :event [:InsertEnter :CmdLineEnter]
               :requires [(pack :zbirenbaum/copilot-cmp {:opt true})
                          (pack :hrsh7th/cmp-path {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-buffer {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-cmdline {:after :nvim-cmp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :nvim-cmp})
                          (pack :L3MON4D3/LuaSnip
                                {:event [:InsertEnter :CmdLineEnter]
                                 :wants :friendly-snippets
                                 :requires [(pack :rafamadriz/friendly-snippets)]})]})
