(import-macros {: use-package!} :macros)

(use-package! :lukas-reineke/headlines.nvim {:ft :org
                                             :call-setup headlines})
(use-package! :akinsho/org-bullets.nvim {:ft :org
                                         :call-setup org-bullets})
