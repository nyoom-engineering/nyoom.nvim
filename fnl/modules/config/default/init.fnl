(import-macros {: use-package! : nyoom-module!} :macros)

(nyoom-module! config.default)

;; Core packages
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})
