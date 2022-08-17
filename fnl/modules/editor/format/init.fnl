(import-macros {: use-package!} :macros)

;; The actual configuration is handled in tools.lsp 
;; This is just to install/enable the modules
(use-package! "jose-elias-alvarez/null-ls.nvim" {:opt true})
