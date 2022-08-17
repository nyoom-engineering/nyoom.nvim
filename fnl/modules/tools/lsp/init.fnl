(import-macros {: use-package!} :macros)

; view lsp loading progress
(use-package! :j-hui/fidget.nvim {:call-setup fidget
                                  :after :nvim-lspconfig})
; view diagnostics ala vscode
(use-package! :folke/trouble.nvim {:call-setup trouble
                                   :cmd :Trouble})
; floating diagnostics as lines instead
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {:call-setup lsp_lines
                                                              :after :nvim-lspconfig})
; easy to use configurations for language servers
(use-package! :neovim/nvim-lspconfig {:opt true
                                      :defer nvim-lspconfig
                                      :nyoom-module tools.lsp})


