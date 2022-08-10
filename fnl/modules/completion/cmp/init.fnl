(import-macros {: use-package! : load-module} :macros.package-macros)

(use-package! :hrsh7th/nvim-cmp
              {:config (load-module completion.cmp)
               :after :friendly-snippets
               :requires [(pack :hrsh7th/cmp-path {:after :cmp-buffer})
                          (pack :hrsh7th/cmp-buffer {:after :cmp-nvim-lsp})
                          (pack :hrsh7th/cmp-nvim-lsp {:after :cmp_luasnip})
                          (pack :PaterJason/cmp-conjure {:after :conjure})
                          (pack :saadparwaiz1/cmp_luasnip {:after :LuaSnip})
                          (pack :rafamadriz/friendly-snippets {:module [:cmp :cmp_nvim_lsp] :event :InsertEnter})
                          (pack :L3MON4D3/LuaSnip {:event :InsertEnter
                                                   :wants :friendly-snippets
                                                   :config (fn []
                                                             (local {: lazy_load} (require :luasnip/loaders/from_vscode))
                                                             (lazy_load))})]})


