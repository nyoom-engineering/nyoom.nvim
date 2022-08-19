(import-macros {: use-package!} :macros)

;; Core packages
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

;; an actual, valid use case for this plugin. incredible. In lua, of course
(use-package! :michaelb/do-nothing.vim {:nyoom-module config.default
                                        :branch :lua})
