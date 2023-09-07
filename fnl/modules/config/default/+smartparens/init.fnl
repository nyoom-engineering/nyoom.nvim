(import-macros {: use-package!} :macros)

;; Simple parenthesis matching
(use-package! :windwp/nvim-autopairs {:nyoom-module config.default.+smartparens
                                      :event :InsertEnter})

; lua-based matchparen alternative
(use-package! :monkoose/matchparen.nvim {:opt true
                                         :defer matchparen.nvim
                                         :call-setup matchparen})
