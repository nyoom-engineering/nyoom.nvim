(import-macros {: use-package!} :conf.macros)

;; Bootstrap essential plugins
(use-package! :wbthomason/packer.nvim)
(use-package! :lewis6991/impatient.nvim)

;; not core, but everyone uses it
(use-package! :numToStr/Comment.nvim {:init :Comment})

;; very useful for newcomers
(use-package! :folke/which-key.nvim {:init :which-key})
