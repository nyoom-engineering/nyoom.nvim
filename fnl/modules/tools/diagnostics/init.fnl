(import-macros {: use-package!} :macros)

(use-package! :mfussenegger/nvim-lint {:nyoom-module tools.diagnostics
                                       :opt true
                                       :defer nvim-lint})

; view diagnostics ala vscode
(use-package! :folke/trouble.nvim {:call-setup trouble
                                   :cmd :Trouble})

; floating diagnostics as lines instead
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim" {:call-setup lsp_lines
                                                              :after :nvim-lspconfig})
