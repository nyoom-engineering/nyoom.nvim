(import-macros {: use-package!} :macros)

(use-package! :anuvyklack/hydra.nvim
              {:nyoom-module ui.hydra
               :module :hydra
               :keys [:<leader>g
                      :<leader>v
                      :<leader>f
                      :<leader>d
                      :<leader>m
                      :<leader>t]})
