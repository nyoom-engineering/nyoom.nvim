(import-macros {: use-package!} :macros)

(use-package! :jose-elias-alvarez/null-ls.nvim
              {:nyoom-module checkers.diagnostics :after :nvim-lspconfig})

;; floating diagnostics as lines instead
(use-package! "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
              {:call-setup lsp_lines :after :nvim-lspconfig})
