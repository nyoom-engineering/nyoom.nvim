(import-macros {: use-package!} :macros)

(use-package! :anuvyklack/hydra.nvim
              {:nyoom-module ui.hydra
               :module :hydra
               :keys [:<leader>g
                      :<leader>o
                      :<leader>f
                      :<leader>z
                      :<leader>m
                      :<leader>d]})
