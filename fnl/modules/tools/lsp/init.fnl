(import-macros {: use-package!} :macros)

; view lsp loading progress
(use-package! :j-hui/fidget.nvim {:call-setup fidget
                                  :after :nvim-lspconfig})

; easy to use configurations for language servers
(use-package! :neovim/nvim-lspconfig {:opt true
                                      :defer nvim-lspconfig
                                      :nyoom-module tools.lsp})
