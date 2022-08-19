(import-macros {: use-package!} :macros)

;; Core packages
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})
(use-package! :kylechui/nvim-surround {:nyoom-module config.default})
