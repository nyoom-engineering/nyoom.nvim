(import-macros {: use-package!} :macros)

; easy to use configurations for language servers
(use-package! :neovim/nvim-lspconfig
              {:nyoom-module tools.lsp :opt true :defer nvim-lspconfig})
