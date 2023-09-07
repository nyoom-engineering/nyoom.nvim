(import-macros {: use-package!} :macros)

;; view diagnostics ala vscode
(use-package! :folke/trouble.nvim {:call-setup trouble :cmd :Trouble})
