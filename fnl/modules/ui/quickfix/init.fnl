(import-macros {: use-package!} :macros)

;; view diagnostics ala vscode
(use-package! :yorickpeterse/nvim-pqf {:call-setup nvim-pqf :cmd [:copen :cclose]})
